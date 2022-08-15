import { NextFunction, Request, Response } from "express";
import { validationResult } from "express-validator";
import CreateHttpError from "../utils/CreateHttpError";

const validateRequestBody = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const errors = validationResult(req);

  if (!errors.isEmpty())
    return next(CreateHttpError.unprocessableEntity(errors.array()[0].msg));

  next();
};

export default validateRequestBody;