import { Router } from "express";
import uploadImage from "../config/multerConfig";
import {
  createNewPostHandler,
  getAllPostsHandler,
} from "../controllers/post.controller";
import authenticate from "../middleware/authenticate";
import { uploadAsPostImages } from "../middleware/compressFile";

const postRouter = Router();

postRouter
  .route("/")
  .post(
    [authenticate, uploadImage.array("images", 10), uploadAsPostImages],
    createNewPostHandler
  )
  .get([authenticate], getAllPostsHandler);

export default postRouter;
