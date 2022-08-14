import { NextFunction, Request, Response } from "express";
import rateLimit from "express-rate-limit";
import CreateHttpError from "../utils/CreateHttpError";

const options = {
  max: 5,
  standardHeaders: true,
  legacyHeaders: false,
  handler: (req: Request, res: Response, next: NextFunction) => {
    return next(
      CreateHttpError.toManyRequest(
        "We have detected too many request from this IP, please try again after an 15 minutes!"
      )
    );
  },
};

const singInLimiter = rateLimit({ ...options, windowMs: 1000 * 60 * 15 });
const resendOtpLimiter = rateLimit({ ...options, windowMs: 1000 * 60 * 15 });
const verifyOtpLimiter = rateLimit({ ...options, windowMs: 1000 * 60 * 15 });
const signUpLimiter = rateLimit({ ...options, windowMs: 1000 * 60 * 15 });
const forgotPasswordLimiter = rateLimit({
  ...options,
  windowMs: 1000 * 60 * 15,
});

export {
  singInLimiter,
  resendOtpLimiter,
  verifyOtpLimiter,
  signUpLimiter,
  forgotPasswordLimiter,
};
