import {
  ACCESS_TOKEN_SECRET,
  REFRESH_TOKEN_SECRET,
} from "../constants/secrets";
import jwt from "jsonwebtoken";

const generateJwt = (id: string) => {
  const accessToken = jwt.sign({ id }, ACCESS_TOKEN_SECRET, {
    expiresIn: "1h",
  });

  const refreshToken = jwt.sign({ id }, REFRESH_TOKEN_SECRET, {
    expiresIn: "7d",
  });

  return { accessToken, refreshToken };
};

export default generateJwt;
