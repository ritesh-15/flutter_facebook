import { Schema } from "express-validator";

export const activateSchema: Schema = {
  firstName: {
    in: ["body"],
    isString: true,
    trim: true,
    exists: true,
    notEmpty: true,
    errorMessage: "First name is required!",
  },
  lastName: {
    in: ["body"],
    isString: true,
    trim: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Last name is required!",
  },
  password: {
    in: ["body"],
    isString: true,
    isStrongPassword: true,
    exists: true,
    notEmpty: true,
    errorMessage:
      "Password cannot be empty and password length should be greater than 8 characters!",
  },
};
