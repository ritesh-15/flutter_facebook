import { config } from "dotenv";
config();

export const ACCESS_TOKEN_SECRET: string = process.env.ACCESS_TOKEN_SECRET!!;

export const REFRESH_TOKEN_SECRET: string = process.env.REFRESH_TOKEN_SECRET!!;

export const SEND_GRID_API_KEY: string = process.env.SEND_GRID_API_KEY!!;

export const SEND_GRID_EMAIL: string = process.env.SEND_GRID_EMAIL!!;

export const OTP_HASH_SECRET: string = process.env.OTP_HASH_SECRET!!;

export const APP_BASE_URL: string = process.env.APP_BASE_URL!!;

export const FORGOT_PASSWORD_SECRET: string =
  process.env.FORGOT_PASSWORD_SECRET!!;
