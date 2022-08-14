import { Router } from "express";
import { checkSchema } from "express-validator";
import { activate, updateProfile } from "../controllers/user.controller";
import authenticate from "../middleware/authenticate";
import validateRequestBody from "../middleware/validateRequestBody";
import { activateSchema } from "../validation/user";

const userRouter = Router();

userRouter.put(
  "/activate",
  checkSchema(activateSchema),
  validateRequestBody,
  authenticate,
  activate
);

userRouter.route("/update-profile").put(authenticate, updateProfile);

export default userRouter;
