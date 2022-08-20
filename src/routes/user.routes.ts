import { Router } from "express";
import { checkSchema } from "express-validator";
import uploadImage from "../config/multerConfig";
import {
  activate,
  deleteAccount,
  follow,
  followersAndFollowings,
  getMe,
  getUsers,
  singleUser,
  updateAvatar,
  updateProfile,
  uploadCover,
} from "../controllers/user.controller";
import authenticate from "../middleware/authenticate";
import { uploadAsCover, uploadAsAvatar } from "../middleware/uploadAsAvatar";
import validateRequestBody from "../middleware/validateRequestBody";
import {
  activateSchema,
  followSchema,
  unFollowSchema,
  updateProfileSchema,
} from "../validation/user";

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

userRouter.post(
  "/follow/:id",
  [authenticate],
  checkSchema(followSchema),
  validateRequestBody,
  follow
);

userRouter.post(
  "/unfollow/:id",
  [authenticate],
  checkSchema(unFollowSchema),
  validateRequestBody,
  follow
);

userRouter.get("/followers-followings", [authenticate], followersAndFollowings);

userRouter.get("/:id", [authenticate], singleUser);

export default userRouter;
