import { Router } from "express";
import { checkSchema } from "express-validator";
import {
  forgotPasswordLimiter,
  resendOtpLimiter,
  signUpLimiter,
  singInLimiter,
  verifyOtpLimiter,
} from "../config/authLimiter";
import {
  forgotPassword,
  logout,
  refresh,
  resendOtp,
  signIn,
  signUp,
  verifyOtp,
} from "../controllers/auth.controller";
import authenticate from "../middleware/authenticate";
import validateRequestBody from "../middleware/validateRequestBody";
import {
  forgotPasswordSchema,
  refreshSchema,
  resendOtpSchema,
  signInSchema,
  signupSchema,
  verifyOtpSchema,
} from "../validation/auth";

const authRouter = Router();

authRouter.post(
  "/signup",
  signUpLimiter,
  checkSchema(signupSchema),
  validateRequestBody,
  signUp
);

authRouter.post(
  "/signin",
  singInLimiter,
  checkSchema(signInSchema),
  validateRequestBody,
  signIn
);

authRouter.post(
  "/verifyOtp",
  verifyOtpLimiter,
  checkSchema(verifyOtpSchema),
  validateRequestBody,
  verifyOtp
);

authRouter.post(
  "/resendOtp",
  resendOtpLimiter,
  checkSchema(resendOtpSchema),
  validateRequestBody,
  resendOtp
);

authRouter.get(
  "/refresh",
  checkSchema(refreshSchema),
  validateRequestBody,
  refresh
);

authRouter.delete("/logout", authenticate, logout);

authRouter.post(
  "/forgot-password",
  forgotPasswordLimiter,
  checkSchema(forgotPasswordSchema),
  validateRequestBody,
  forgotPassword
);

export default authRouter;
