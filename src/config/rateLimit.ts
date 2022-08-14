import rateLimit from "express-rate-limit";
import CreateHttpError from "../utils/CreateHttpError";

const rateLimiter = rateLimit({
  windowMs: 60 * 60 * 1000,
  max: 200,
  standardHeaders: true,
  legacyHeaders: false,
  handler: (req, res, next) => {
    return next(CreateHttpError.toManyRequest());
  },
});

export default rateLimiter;
