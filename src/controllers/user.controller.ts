import { NextFunction, Request, Response } from "express";
import UserService from "../services/user.service";
import CreateHttpError from "../utils/CreateHttpError";
import bcrypt from "bcrypt";
import RedisHelper from "../helpers/RedisHelper";
import CloudinaryHelper from "../helpers/CloudinaryHelper";
import fs from "fs/promises";
import extractPublicIdFromUrl from "../utils/getPublicIdFromUrl";

interface ActivateInterface {
  firstName: string;
  lastName: string;
  password: string;
}

/**
 * 
 *@route   PUT api/users/activate
  @desc    Activate users account
  @access  Private
 * 
 */
export const activate = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { firstName, lastName, password } = req.body as ActivateInterface;

  if (req.user?.isActivated) {
    return next(CreateHttpError.forbidden("Account already activated!"));
  }

  try {
    const hashPassword = await bcrypt.hash(password, 12);

    const user = await UserService.update(
      { id: req.user?.id! },
      { firstName, lastName, password: hashPassword, isActivated: true }
    );

    res.json({
      ok: true,
      user,
      message: "Account activated successfully",
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

/**
 * 
 *@route   GET api/users/me
  @desc    Get account details
  @access  Private
 * 
 */
export const getMe = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    let user = await RedisHelper.get(`${RedisHelper.USER}-${req.user?.id}`);

    if (user) {
      return res.json({
        ok: true,
        message: "Fetch user successfully",
        user: JSON.parse(user),
      });
    }

    user = await UserService.findUnique({ id: req.user?.id });

    if (!user) {
      return next(CreateHttpError.notFound("User not found"));
    }

    await RedisHelper.set(
      `${RedisHelper.USER}-${user.id}`,
      JSON.stringify(user)
    );

    return res.json({
      ok: true,
      message: "Fetch user successfully",
      user,
    });
  } catch (error) {
    return next(CreateHttpError.internalServerError());
  }
};

interface UpdateProfileInterface {
  firstName: string;
  lastName: string;
  bio: string;
}

/**
 * 
 *@route   PUT api/users
  @desc    Update user profile
  @access  Private
 * 
 */
export const updateProfile = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { firstName, lastName, bio } = req.body as UpdateProfileInterface;

  try {
    const user = await UserService.update(
      { id: req.user?.id },
      {
        firstName,
        lastName,
        bio,
      }
    );

    await RedisHelper.set(
      `${RedisHelper.USER}-${user.id}`,
      JSON.stringify(user)
    );

    return res.json({
      ok: true,
      message: "Profile updated successfully!",
      user,
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

/**
 * 
 *@route   DELETE api/users
  @desc    Delete user account
  @access  Private
 * 
 */
export const deleteAccount = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    await UserService.deleteOne(req.user?.id!);

    // clear the cookies
    res.clearCookie("accessToken");
    res.clearCookie("refreshToken");

    await RedisHelper.remove(`${RedisHelper.USER}-${req.user?.id!}`);

    return res.json({
      ok: true,
      message: "Delete account successfully",
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

interface GetUsersQuery {
  page?: string;
  query?: string;
}

/**
 * 
 *@route   GET api/users
  @desc    Get all users
  @access  Private
 * 
 */
// !: remaining this method
export const getUsers = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { page, query } = req.query as GetUsersQuery;

  const filter = query
    ? {
        OR: [
          {
            firstName: {
              contains: query,
              mode: "insensitive",
            },
          },
          {
            lastName: {
              contains: query,
              mode: "insensitive",
            },
          },
          {
            email: {
              contains: query,
              mode: "insensitive",
            },
          },
        ],
      }
    : {};

  try {
    const users = await UserService.findAllUsers({
      select: { id: true, avatar: true, firstName: true, lastName: true },
      filter: filter,
    });

    res.json({
      ok: true,
      message: "Fetched users!",
      users,
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

/**
 * 
 *@route   POST api/users/update-avatar
  @desc    Update user avatar
  @access  Private
 * 
 */
export const updateAvatar = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (!req.file) {
    return next(CreateHttpError.badRequest("No file uploaded"));
  }

  try {
    const uploadResult = await CloudinaryHelper.uploadImage(req.file.path);

    await fs.unlink(req.file.path);

    if (req.user?.avatar != null) {
      const publicId = extractPublicIdFromUrl(req.user?.avatar);
      await CloudinaryHelper.deleteImageByPublicId(publicId);
    }

    const user = await UserService.update(
      { id: req.user?.id! },
      {
        avatar: uploadResult.secure_url,
      }
    );

    await RedisHelper.set(
      `${RedisHelper.USER}-${user.id}`,
      JSON.stringify(user)
    );

    res.json({
      ok: true,
      message: "Uploaded avatar successfully!",
      user,
    });
  } catch (error) {
    return next(CreateHttpError.internalServerError());
  }
};

/**
 * 
 *@route   POST api/users/update-cover
  @desc    Update user avatar
  @access  Private
 * 
 */
export const uploadCover = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (!req.file) {
    return next(CreateHttpError.badRequest("No file uploaded"));
  }

  try {
    const uploadResult = await CloudinaryHelper.uploadImage(req.file.path);

    await fs.unlink(req.file.path);

    if (req.user?.cover != null) {
      const publicId = extractPublicIdFromUrl(req.user?.cover);
      await CloudinaryHelper.deleteImageByPublicId(publicId);
    }

    const user = await UserService.update(
      { id: req.user?.id! },
      {
        cover: uploadResult.secure_url,
      }
    );

    await RedisHelper.set(
      `${RedisHelper.USER}-${user.id}`,
      JSON.stringify(user)
    );

    res.json({
      ok: true,
      message: "Uploaded avatar successfully!",
      user,
    });
  } catch (error) {
    return next(CreateHttpError.internalServerError());
  }
};
