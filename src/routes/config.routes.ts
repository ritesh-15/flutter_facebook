import { Application, NextFunction, Request, Response } from "express";
import {
  resetPassword,
  resetPasswordPost,
} from "../controllers/auth.controller";
import CreateHttpError from "../utils/CreateHttpError";
import authRouter from "./auth.routes";
import userRouter from "./user.routes";

const configRoutes = (app: Application) => {
  app.use("/api/auth", authRouter);

  app.use("/api/users", userRouter);

  app.get("/reset-password", resetPassword);

  app.post("/reset-password", resetPasswordPost);

  app.use((req: Request, res: Response, next: NextFunction) => {
    return next(CreateHttpError.notImplemented());
  });
};

export default configRoutes;
