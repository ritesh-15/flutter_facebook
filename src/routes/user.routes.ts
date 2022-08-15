import { Router } from "express";
import { checkSchema } from "express-validator";
import uploadImage from "../config/multerCoinfg";
import {
  activate,
  deleteAccount,
  getMe,
  getUsers,
  updateProfile,
} from "../controllers/user.controller";
import authenticate from "../middleware/authenticate";
import validateRequestBody from "../middleware/validateRequestBody";
import { activateSchema, updateProfileSchema } from "../validation/user";

const userRouter = Router();

userRouter.put(
  "/activate",
  checkSchema(activateSchema),
  validateRequestBody,
  authenticate,
  activate
);

userRouter.get("/me", authenticate, getMe);

userRouter
  .route("/")
  .put(
    authenticate,
    checkSchema(updateProfileSchema),
    validateRequestBody,
    updateProfile
  )
  .delete(authenticate, deleteAccount)
  .get(authenticate, getUsers);

export default userRouter;
