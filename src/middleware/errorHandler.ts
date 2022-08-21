import { NextFunction, Request, Response } from "express";
import CreateHttpError from "../utils/CreateHttpError";
import logger from "../utils/logger";

const errorHandler = (
  error: Error,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (error instanceof CreateHttpError) {
    logger.error(error);

    return res.status(error.status).json({
      ok: false,
      message: error.message,
      code: error.status,
      error: error.error,
    });
  }

  logger.error(error);

  return res.status(500).json({
    ok: false,
    message: "Internal server error!",
    code: 500,
    error: "Internal server error!",
  });
};

export default errorHandler;
