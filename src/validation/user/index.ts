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

export const updateProfileSchema: Schema = {
  firstName: {
    in: ["body"],
    isString: true,
    trim: true,
    notEmpty: true,
    errorMessage: "First name cannot be empty!",
    optional: {
      options: {
        nullable: false,
      },
    },
  },
  lastName: {
    in: ["body"],
    isString: true,
    trim: true,
    notEmpty: true,
    errorMessage: "Last name is cannot be empty",
    optional: {
      options: {
        nullable: false,
      },
    },
  },
  bio: {
    in: ["body"],
    isString: true,
    trim: true,
    notEmpty: true,
    errorMessage: "Bio cannot be empty!",
    optional: {
      options: {
        nullable: false,
      },
    },
  },
};

export const followSchema: Schema = {
  id: {
    in: ["params"],
    exists: true,
    isString: true,
    isUUID: true,
    notEmpty: true,
    errorMessage: "Follower id is required!",
  },
};

export const unFollowSchema: Schema = {
  id: {
    in: ["params"],
    exists: true,
    isString: true,
    isUUID: true,
    notEmpty: true,
    errorMessage: "Follower id is required!",
  },
};

export const getProfileSchema: Schema = {
  id: {
    in: ["query"],
    isString: true,
    isUUID: true,
    notEmpty: true,
    optional: {
      options: {
        nullable: false,
      },
    },
    errorMessage: "User id is not valid!",
  },
};
