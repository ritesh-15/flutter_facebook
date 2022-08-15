import { NextFunction, Request, Response } from "express";
import CreateHttpError from "../utils/CreateHttpError";
import Jimp from "jimp";

const uploadAsAvatar = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (!req.file) {
    return next(CreateHttpError.badRequest("No image found to upload!"));
  }

  try {
    const image = await Jimp.read(req.file.path);
    await image.resize(250, Jimp.AUTO).quality(60).writeAsync(req.file.path);

    next();
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

const uploadAsCover = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (!req.file) {
    return next(CreateHttpError.badRequest("No image found to upload!"));
  }

  try {
    const image = await Jimp.read(req.file.path);
    await image.resize(500, Jimp.AUTO).quality(60).writeAsync(req.file.path);

    next();
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

export { uploadAsAvatar, uploadAsCover };
