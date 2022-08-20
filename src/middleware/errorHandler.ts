import { NextFunction, Request, Response } from "express";
import CreateHttpError from "../utils/CreateHttpError";

const errorHandler = (
  error: Error,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (error instanceof CreateHttpError) {
    return res.status(error.status).json({
      ok: false,
      message: error.message,
      code: error.status,
      error: error.error,
    });
  }

  console.log(error);

  return res.status(500).json({
    ok: false,
    message: "Internal server error!",
    code: 500,
    error: "Internal server error!",
  });
};

export default errorHandler;
