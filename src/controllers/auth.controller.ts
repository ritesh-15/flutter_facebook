import { NextFunction, Request, Response } from "express";
import CreateHttpError from "../utils/CreateHttpError";
import bcrypt from "bcrypt";
import OtpService from "../services/otp.service";
import UserService from "../services/user.service";
import JwtHelper from "../helpers/JwtHelper";
import getTokenFromRequest from "../utils/getTokenFromRequest";
import { MailOptions, sendEmail } from "../services/email.service";
import { APP_BASE_URL } from "../constants/secrets";
import forgotPasswordTemplate from "../utils/forgotPasswordTemplate";

interface SignupInterface {
  email: string;
}

// @route   POST api/auth/signup
// @desc    Register user
// @access  Public
export const signUp = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { email } = req.body as SignupInterface;

  try {
    const isExits = await UserService.findUnique({ email }, { id: true });

    if (isExits)
      return next(
        CreateHttpError.badRequest(
          "User with given email address is already exits"
        )
      );

    await UserService.create(email);

    const otpService = new OtpService({ email });
    const hashedOtp = otpService.hash();
    await otpService.send();

    res.status(201).json({
      ok: true,
      message: "Verification code sent successfully!",
      otp: {
        hash: hashedOtp,
        email: email,
      },
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

interface SignInInterface {
  email: string;
  password: string;
}

// @route   POST api/auth/signin
// @desc    Login user
// @access  Public
export const signIn = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { email, password } = req.body as SignInInterface;

  try {
    const user = await UserService.findUnique(
      { email },
      { ...UserService.SelectOptions, password: true }
    );

    if (!user)
      return next(
        CreateHttpError.notFound("Invalid email address or password!")
      );

    if (!user.isActivated) {
      return next(CreateHttpError.forbidden("Account is not activated!"));
    }

    const isMatch = await bcrypt.compare(password, user.password!);

    if (!isMatch)
      return next(
        CreateHttpError.badRequest("Invalid email address or password!")
      );

    const { accessToken, refreshToken } = JwtHelper.generateTokens(user.id!);
    await JwtHelper.storeInCache(user.id!, refreshToken);
    JwtHelper.setInCookie(res, "accessToken", accessToken);
    JwtHelper.setInCookie(res, "refreshToken", refreshToken);

    res.json({
      ok: true,
      message: "User signed in successfully!",
      user: {
        ...user,
        password: null,
      },
      accessToken,
      refreshToken,
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

interface VerifyOtpInterface {
  email: string;
  code: number;
  hash: string;
}
// @route   POST api/auth/verifyOtp
// @desc    Verify Otp
// @access  Public
export const verifyOtp = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { email, code, hash } = req.body as VerifyOtpInterface;

  try {
    let user = await UserService.findUnique({ email });

    if (!user)
      return next(
        CreateHttpError.notFound("User not exits with given email address!")
      );

    const [originalHash, expiresIn] = hash.split(".");

    if (Number(expiresIn) < Date.now())
      return next(CreateHttpError.forbidden("Verification code expired!"));

    const isValid = OtpService.verify({
      email,
      code,
      hash: originalHash,
      expiresIn,
    });

    if (!isValid)
      return next(CreateHttpError.forbidden("Invalid verification code"));

    user = await UserService.update({ id: user.id! }, { isVerified: true });

    const { accessToken, refreshToken } = JwtHelper.generateTokens(user?.id!);
    await JwtHelper.storeInCache(user?.id!, refreshToken);
    JwtHelper.setInCookie(res, "accessToken", accessToken);
    JwtHelper.setInCookie(res, "refreshToken", refreshToken);

    res.json({
      ok: true,
      message: "User verified successfully",
      user,
      accessToken,
      refreshToken,
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

interface ResendOtpInterface {
  email: string;
}

// @route   POST api/auth/resendOtp
// @desc    Resend Otp
// @access  Public
export const resendOtp = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { email } = req.body as ResendOtpInterface;

  try {
    const user = await UserService.findUnique({ email }, { id: true });

    if (!user)
      return next(
        CreateHttpError.notFound("User not exits with given email address!")
      );

    const otpService = new OtpService({ email });
    const hashedOtp = otpService.hash();
    await otpService.send();

    res.json({
      ok: true,
      message: "Verification code sent successfully",
      otp: {
        hash: hashedOtp,
        email: email,
      },
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

// @route   GET api/auth/refresh
// @desc    Refresh token
// @access  Public
export const refresh = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const receivedRefreshToken = getTokenFromRequest(req, "refreshToken");

  if (!receivedRefreshToken)
    return next(CreateHttpError.notFound("Token not found!"));

  let jwtPayload = null;

  try {
    jwtPayload = JwtHelper.validateRefreshToken(receivedRefreshToken);
  } catch (error) {
    return next(CreateHttpError.unauthorized("Token expired!"));
  }

  try {
    const session = await JwtHelper.getFromCache(jwtPayload.id);

    if (!session) return next(CreateHttpError.unauthorized("Invalid session"));

    if (session !== receivedRefreshToken)
      return next(CreateHttpError.unauthorized("Invalid session"));

    const user = await UserService.findUnique({ id: jwtPayload.id });

    if (!user) return next(CreateHttpError.unauthorized("Invalid session"));

    const { accessToken, refreshToken } = JwtHelper.generateTokens(
      jwtPayload.id
    );
    await JwtHelper.storeInCache(jwtPayload.id, refreshToken);
    JwtHelper.setInCookie(res, "accessToken", accessToken);
    JwtHelper.setInCookie(res, "refreshToken", refreshToken);

    res.json({
      ok: true,
      message: "Token refreshed successfully",
      user,
      accessToken,
      refreshToken,
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

// @route   DELETE api/auth/logout
// @desc    Log out user
// @access  Private
export const logout = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    await JwtHelper.removeFromCache(req.user?.id!);
    res.clearCookie("accessToken");
    res.clearCookie("refreshToken");

    res.json({
      ok: true,
      message: "User logged out successfully",
    });
  } catch (error) {
    next(CreateHttpError.internalServerError());
  }
};

interface ForgotPasswordInterface {
  email: string;
}

// @route   DELETE api/auth/logout
// @desc    Log out user
// @access  Private
export const forgotPassword = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { email } = req.body as ForgotPasswordInterface;

  try {
    const user = await UserService.findUnique(
      { email },
      { id: true, email: true }
    );

    if (!user) {
      return next(CreateHttpError.notFound("User not found!"));
    }

    const secret = JwtHelper.generateForgotPasswordToken(user.id);

    const resetLink = `${APP_BASE_URL}/reset-password?token=${secret}&email=${user.email}`;

    const mailOptions: MailOptions = {
      to: email,
      subject: "Forgot Your Password!",
      text: `Forgot your password by going to  the link ${resetLink}`,
      html: forgotPasswordTemplate(resetLink),
    };

    await sendEmail(mailOptions);

    await UserService.update(
      { id: user.id },
      {
        resetToken: secret,
        resetExpiry: new Date(Date.now() + 1000 * 60 * 10),
      }
    );

    res.json({
      ok: true,
      message: "Forgot password link sent successfully",
    });
  } catch (error: any) {
    next(CreateHttpError.internalServerError());
  }
};

export const resetPassword = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { token, email } = req.query;

  try {
    if (!token || !email) throw Error();

    const payload = JwtHelper.validateForgotPasswordToken(String(token));

    const user = await UserService.findUnique(
      { id: payload.id },
      { id: true, email: true, resetExpiry: true, resetToken: true }
    );

    if (!user) throw Error();

    if (!user.resetToken) throw Error();

    return res.render("reset-password", {
      isSuccess: false,
      isValid: true,
      token,
      email,
      error: "",
    });
  } catch (error) {
    return res.render("reset-password", {
      isSuccess: false,
      isValid: false,
      token,
      email,
      error: "",
    });
  }
};

export const resetPasswordPost = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const { password, confirmPassword } = req.body;
  const { token, email } = req.query;

  try {
    if (!token || !email) throw new Error();

    if (password !== confirmPassword)
      return res.render("reset-password", {
        isValid: true,
        token,
        email,
        error: "Password and confirm password do not match!",
      });

    const user = await UserService.findUnique(
      { email: String(email) },
      { id: true, email: true, resetExpiry: true, resetToken: true }
    );

    if (!user.resetToken)
      return res.render("reset-password", {
        isSuccess: false,
        isValid: false,
        token,
        email,
        error: "",
      });

    const hashPassword = await bcrypt.hash(password, 12);

    await UserService.update(
      { id: user.id },
      { password: hashPassword, resetExpiry: undefined, resetToken: "" }
    );

    return res.render("reset-password", {
      isSuccess: true,
      isValid: false,
      token,
      email,
      error: "",
    });
  } catch (error) {
    return res.render("reset-password", {
      isSuccess: false,
      isValid: true,
      token,
      email,
      error: "Something went wrong please try again!",
    });
  }
};
