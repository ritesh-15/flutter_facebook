import { NextFunction, Request, Response } from "express";
import CreateHttpError from "../utils/CreateHttpError";
import bcrypt from "bcrypt";
import OtpService from "../services/otp.service";
import UserService from "../services/user.service";
import JwtHelper, { JwtPayloadCustom } from "../helpers/JwtHelper";
import getTokenFromRequest from "../utils/getTokenFromRequest";
import { MailOptions, sendEmail } from "../services/email.service";
import { APP_BASE_URL } from "../constants/secrets";
import forgotPasswordTemplate from "../utils/forgotPasswordTemplate";
import SessionService from "../services/session.service";

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

    const jwtHelper = new JwtHelper();

    const { accessToken, refreshToken } = jwtHelper.generateTokens(user.id!);
    jwtHelper.setInCookie(res, "accessToken", accessToken);
    jwtHelper.setInCookie(res, "refreshToken", refreshToken);

    await jwtHelper.createSession({ token: refreshToken, userId: user.id! });

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

    const jwtHelper = new JwtHelper();
    const { accessToken, refreshToken } = jwtHelper.generateTokens(user?.id!);

    jwtHelper.setInCookie(res, "accessToken", accessToken);
    jwtHelper.setInCookie(res, "refreshToken", refreshToken);

    await jwtHelper.createSession({ token: refreshToken, userId: user?.id! });

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
  const receivedRefreshToken = getTokenFromRequest(
    req,
    "refreshToken",
    "refreshToken"
  );

  if (!receivedRefreshToken)
    return next(CreateHttpError.unauthorized("Token not found!"));

  let jwtPayload: JwtPayloadCustom | null = null;

  try {
    jwtPayload = JwtHelper.validateRefreshToken(receivedRefreshToken);
  } catch (error) {
    return next(CreateHttpError.unauthorized("Token expired!"));
  }

  // find the session by refresh token
  try {
    const foundSession = await SessionService.findSession({
      token: receivedRefreshToken,
    });

    //?? Token reuse case

    if (!foundSession) {
      res.clearCookie("accessToken");
      res.clearCookie("refreshToken");

      await SessionService.deleteAllSessions(jwtPayload.id);

      return next(CreateHttpError.unauthorized("Forbidden access!"));
    }

    const user = await UserService.findUnique({ id: jwtPayload.id });

    if (!user) return next(CreateHttpError.notFound("User not found!"));

    const jwtHelper = new JwtHelper();
    const { accessToken, refreshToken } = jwtHelper.generateTokens(
      jwtPayload.id
    );

    await jwtHelper.createSession({ token: refreshToken, userId: user.id });

    jwtHelper.setInCookie(res, "accessToken", accessToken);
    jwtHelper.setInCookie(res, "refreshToken", refreshToken);

    await SessionService.deleteSession({ id: foundSession.id });

    return res.json({
      ok: true,
      message: "Tokens refresh successfully!",
      accessToken,
      refresh,
    });
  } catch (error) {
    return next(CreateHttpError.internalServerError());
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
    await SessionService.deleteAllSessions(req.user?.id!);

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

// @route   POST api/auth/forgot-password
// @desc    Forgot password
// @access  Public
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

// @route   GET /reset-password
// @desc    Checks for forgot password token and render the form
// @access  Public
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

// @route   POST /reset-password
// @desc    Reset the password only if valid token
// @access  Public
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
