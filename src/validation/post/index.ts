import { Schema } from "express-validator";

export const createPostSchema: Schema = {
  content: {
    in: ["body"],
    isString: true,
    exists: true,
    notEmpty: true,
    errorMessage: "Post content is required!",
  },
};
