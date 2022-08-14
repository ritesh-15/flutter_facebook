import { Schema } from "express-validator";

export const verifyOtpSchema: Schema = {
  email: {
    in: ["body"],
    isString: true,
    isEmail: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Email address is required and must be a valid email address",
  },
  hash: {
    in: ["body"],
    isString: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Verification code hash is required",
  },
  code: {
    in: ["body"],
    isInt: true,
    isLength: {
      options: {
        max: 4,
        min: 4,
      },
      errorMessage: "Verification code is not valid",
    },
    exists: true,
    notEmpty: true,
    errorMessage: "Verification code is required",
  },
};

export const signupSchema: Schema = {
  email: {
    in: ["body"],
    isEmail: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Email address is required and must be a valid email address",
  },
};

export const resendOtpSchema: Schema = {
  email: {
    in: ["body"],
    isEmail: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Email address must be provided and should be valid",
  },
};

export const signInSchema: Schema = {
  email: {
    in: ["body"],
    isEmail: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Email address must be provided and should be valid",
  },
  password: {
    in: ["body"],
    isString: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Password is required!",
  },
};

export const refreshSchema: Schema = {
  refreshToken: {
    in: ["headers", "cookies"],
    isString: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Refresh token not found!",
  },
};

export const forgotPasswordSchema: Schema = {
  email: {
    in: ["body"],
    isEmail: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Email address is required and must be a valid email address",
  },
};

export const resetPasswordSchema: Schema = {
  token: {
    in: ["query"],
    isString: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Token secret is required!",
  },
  email: {
    in: ["query"],
    isEmail: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Email is required!",
  },
};
