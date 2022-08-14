import { Router } from "express";
import { checkSchema } from "express-validator";
import authLimiter from "../config/authLimiter";
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
  authLimiter,
  checkSchema(signupSchema),
  validateRequestBody,
  signUp
);

authRouter.post(
  "/signin",
  authLimiter,
  checkSchema(signInSchema),
  validateRequestBody,
  signIn
);

authRouter.post(
  "/verifyOtp",
  authLimiter,
  checkSchema(verifyOtpSchema),
  validateRequestBody,
  verifyOtp
);

authRouter.post(
  "/resendOtp",
  authLimiter,
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
  checkSchema(forgotPasswordSchema),
  validateRequestBody,
  forgotPassword
);

export default authRouter;
