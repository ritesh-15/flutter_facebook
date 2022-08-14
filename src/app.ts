import Express, { NextFunction, Request, Response } from "express";
import cors from "cors";
import helmet from "helmet";
import morgan from "morgan";
import errorHandler from "./middleware/errorHandler";
import authRouter from "./routes/auth.routes";
import CreateHttpError from "./utils/CreateHttpError";
import userRouter from "./routes/user.routes";
import rateLimiter from "./config/rateLimit";
import corsOptions from "./config/corsOptions";
import redisConfig from "./config/redisConfig";
import cookieParser from "cookie-parser";
import {
  resetPassword,
  resetPasswordPost,
} from "./controllers/auth.controller";
import path from "path";

const app = Express();

const PORT = process.env.PORT || 9000;

redisConfig();

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

app.use("/api/auth", authRouter);

app.use("/api/users", userRouter);

app.get("/reset-password", resetPassword);

app.post("/reset-password", resetPasswordPost);

app.use((req: Request, res: Response, next: NextFunction) => {
  return next(CreateHttpError.notImplemented());
});

app.use(errorHandler);

app.listen(PORT, () => console.log(`Server listening on port ${PORT} 🚀`));
