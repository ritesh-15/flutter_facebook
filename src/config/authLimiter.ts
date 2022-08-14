import rateLimit from "express-rate-limit";

const authLimiter = rateLimit({
  windowMs: 30 * 60 * 1000,
  max: 500,
  message: "Too many request from this IP, please try again after an hour",
  standardHeaders: true,
  legacyHeaders: false,
});

export default authLimiter;
