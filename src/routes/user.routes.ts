import { Router } from "express";
import { checkSchema } from "express-validator";
import uploadImage from "../config/multerConfig";
import {
  activate,
  deleteAccount,
  getMe,
  getUsers,
  updateAvatar,
  updateProfile,
  uploadCover,
} from "../controllers/user.controller";
import authenticate from "../middleware/authenticate";
import { uploadAsCover, uploadAsAvatar } from "../middleware/uploadAsAvatar";
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

userRouter.post(
  "/update-avatar",
  [authenticate, uploadImage.single("file"), uploadAsAvatar],
  updateAvatar
);

userRouter.post(
  "/update-cover",
  [authenticate, uploadImage.single("file"), uploadAsCover],
  uploadCover
);

export default userRouter;
