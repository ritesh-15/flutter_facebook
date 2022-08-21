import { NextFunction, Request, Response } from "express";
import CloudinaryHelper from "../helpers/CloudinaryHelper";
import postService from "../services/post.service";
import CreateHttpError from "../utils/CreateHttpError";
import fs from "fs/promises";
import { validationResult } from "express-validator";
import logger from "../utils/logger";

/**
 * 
 *@route   POST api/posts/
  @desc    Create a new post
  @access  Private
 * 
 */

interface CreateNewPostBody {
  content: string;
}

export const createNewPostHandler = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { content } = req.body as CreateNewPostBody;

  try {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      return next(CreateHttpError.unprocessableEntity(errors.array()[0].msg));
    }

    const files: any = req.files;

    const images = await Promise.all(
      files.map(async (file: Express.Multer.File) => {
        const uploadedData = await CloudinaryHelper.uploadImage(file.path);
        await fs.unlink(file.path);
        return {
          publicId: uploadedData.public_id,
          url: uploadedData.url,
        };
      })
    );

    const post = await postService.createNewPost({
      content,
      userId: req.user?.id!,
      images: {
        createMany: {
          data: images,
        },
      },
    });

    res.json({
      ok: true,
      message: "Post created successfully!",
      post,
    });
  } catch (error) {
    logger.error(error);
    next(CreateHttpError.internalServerError());
  }
};

/**
 * 
 *@route   POST api/posts/
  @desc    Create a new post
  @access  Private
 * 
 */
export const getAllPostsHandler = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const posts = await postService.getAllPosts({
      select: {
        id: true,
        content: true,
        user: {
          select: {
            id: true,
            avatar: true,
            firstName: true,
            lastName: true,
          },
        },
        images: {
          select: {
            publicId: true,
            url: true,
          },
        },
        isPublic: true,
        createdAt: true,
        likes: true,
      },
      include: {
        _count: {},
      },
    });

    return res.json({
      ok: true,
      message: "Fetched posts successfully!",
      posts,
    });
  } catch (error) {
    logger.error(error);
    next(CreateHttpError.internalServerError());
  }
};
