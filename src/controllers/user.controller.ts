import { NextFunction, Request, Response } from "express";
import UserService from "../services/user.service";
import CreateHttpError from "../utils/CreateHttpError";
import bcrypt from "bcrypt";
import PrismaProvider from "../utils/prisma";
import RedisClient from "../utils/redis";
import RedisHelper from "../helpers/RedisHelper";
import SessionService from "../services/session.service";

interface ActivateInterface {
  firstName: string;
  lastName: string;
  password: string;
}
// @route   POST api/users/activate
// @desc    Activate account
// @access  Private
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

// @route   GET api/users/me
// @desc    Get user details
// @access  Private
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

// @route   PUT api/users
// @desc    Update profile
// @access  Private
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

    return res.json({
      ok: true,
      message: "Profile updated successfully!",
      user,
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

// @route   DELETE api/users
// @desc    Delete account
// @access  Private
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
// @route   GET api/users
// @desc    Get all users
// @access  Private
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
