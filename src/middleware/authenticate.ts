import { NextFunction, Request, Response } from "express";
import CreateHttpError from "../utils/CreateHttpError";
import UserService from "../services/user.service";
import JwtHelper from "../helpers/JwtHelper";
import getTokenFromRequest from "../utils/getTokenFromRequest";

const authenticate = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const token = getTokenFromRequest(req, "authorization");

  try {
    if (!token) throw new Error("No token provided!");

    const payload = JwtHelper.validateAccessToken(token);

    const user = await UserService.findUnique(
      { id: payload.id },
      { id: true, email: true, isActivated: true, isVerified: true }
    );

    if (!user) throw new Error("User not found!");

    req.user = user;

    next();
  } catch (error) {
    next(CreateHttpError.unauthorized());
  }
};

export default authenticate;
