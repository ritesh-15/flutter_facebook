import { Request } from "express";

const getTokenFromRequest = (
  req: Request,
  name: string,
  requiredPrefix: string = "Bearer"
): string | null => {
  let token = null;

  const tokenFromHeader: any = req.headers[name.toLowerCase()];

  if (!tokenFromHeader) {
    token = req.cookies[name];
    if (!token) return null;
    return token;
  }

  const [prefix, actualToken] = tokenFromHeader.split(" ");

  token = actualToken;

  if (prefix !== requiredPrefix) return null;

  return token;
};

export default getTokenFromRequest;
