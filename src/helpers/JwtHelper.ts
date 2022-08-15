import {
  ACCESS_TOKEN_SECRET,
  FORGOT_PASSWORD_SECRET,
  REFRESH_TOKEN_SECRET,
} from "../constants/secrets";
import jwt, { JwtPayload } from "jsonwebtoken";
import RedisClient from "../utils/redis";
import { Request, Response } from "express";
import SessionService from "../services/session.service";

export interface JwtPayloadCustom extends JwtPayload {
  id: string;
}

class JwtHelper {
  static JWT_TOKEN_KEY = "JWT";

  static generateForgotPasswordToken(id: string) {
    return jwt.sign({ id }, FORGOT_PASSWORD_SECRET, {
      expiresIn: "10m",
    });
  }

  generateTokens(id: string) {
    const accessToken = jwt.sign({ id }, ACCESS_TOKEN_SECRET, {
      expiresIn: "15m",
    });

    const refreshToken = jwt.sign({ id }, REFRESH_TOKEN_SECRET, {
      expiresIn: "7d",
    });

    return { accessToken, refreshToken };
  }

  createSession(data: { token: string; userId: string }) {
    return SessionService.createSession(data);
  }

  setInCookie(res: Response, name: string, value: string) {
    res.cookie(name, value, {
      httpOnly: true,
      secure: true,
      expires: new Date(Date.now() + 1000 * 60 * 60 * 24 * 7),
      sameSite: false,
    });
  }

  static validateAccessToken(token: string): JwtPayloadCustom {
    return <JwtPayloadCustom>jwt.verify(token, ACCESS_TOKEN_SECRET);
  }

  static validateForgotPasswordToken(token: string): JwtPayloadCustom {
    return <JwtPayloadCustom>jwt.verify(token, FORGOT_PASSWORD_SECRET);
  }

  static validateRefreshToken(token: string): JwtPayloadCustom {
    return <JwtPayloadCustom>jwt.verify(token, REFRESH_TOKEN_SECRET);
  }
}

export default JwtHelper;
