import { Application } from "express";
import Express from "express";
import rateLimiter from "../config/rateLimit";
import path from "path";
import cookieParser from "cookie-parser";
import corsOptions from "../config/corsOptions";
import cors from "cors";
import helmet from "helmet";
import morgan from "morgan";

const configMiddleWares = (app: Application) => {
  app.use(Express.json({ limit: "10mb" }));

  app.use(rateLimiter);

  app.set("view engine", "ejs");

  app.set("views", path.join(__dirname, "../views"));

  app.use(Express.static(path.join(__dirname, "../public")));

  app.use(cookieParser());

  app.use(Express.urlencoded({ extended: false }));

  app.use(cors(corsOptions));

  app.use(helmet());

  app.use(morgan("dev"));
};

export default configMiddleWares;
