import { NextFunction, Request, Response } from "express";
import UserService from "../services/user.service";
import CreateHttpError from "../utils/CreateHttpError";
import bcrypt from "bcrypt";

export const updateProfile = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  return res.json({
    user: req.user,
  });
};

interface ActivateInterface {
  firstName: string;
  lastName: string;
  password: string;
}
// @route   POST api/auth/verifyOtp
// @desc    Verify Otp
// @access  Public
export const activate = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { firstName, lastName, password } = req.body as ActivateInterface;

  if (req.user?.isActivated) {
    return next(CreateHttpError.forbidden("Account already activated!"));
  }

  try {
    const hashPassword = await bcrypt.hash(password, 12);

    const user = await UserService.update(
      { id: req.user?.id! },
      { firstName, lastName, password: hashPassword, isActivated: true }
    );

    res.json({
      ok: true,
      user,
      message: "Account activated successfully",
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};
