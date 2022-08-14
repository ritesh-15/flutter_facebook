import crypto from "crypto";
import { OTP_HASH_SECRET } from "../constants/secrets";
import { emailTemplate } from "../utils/emailTemplate";
import { MailOptions, sendEmail } from "./email.service";

interface VerificationCodeOptions {
  email: string;
  code?: number;
  expiresIn?: string;
}

interface VerifyCodeOptions extends VerificationCodeOptions {
  hash: string;
}

class OtpService {
  data: string;
  otp: number;
  expiresIn: string;
  email: string;

  generate(): number {
    return crypto.randomInt(9999 - 1000);
  }

  constructor({ email, code, expiresIn }: VerificationCodeOptions) {
    this.otp = code || this.generate();
    this.email = email;
    this.expiresIn = expiresIn || String(Date.now() + 1000 * 60 * 10);
    this.data = `${email}.${OTP_HASH_SECRET}.${this.otp}.${this.expiresIn}`;
  }

  hash() {
    const hash = crypto.createHash("sha256").update(this.data).digest("hex");
    return `${hash}.${this.expiresIn}`;
  }

  send() {
    const mailOptions: MailOptions = {
      to: this.email,
      subject: "Account Verification!",
      text: `Your one time verification code is ${this.otp}`,
      html: emailTemplate(`${this.otp}`),
    };

    return sendEmail(mailOptions);
  }

  static verify({ email, code, expiresIn, hash }: VerifyCodeOptions) {
    const otpService = new OtpService({ email, code, expiresIn });
    return otpService.hash().split(".")[0] === hash;
  }
}

export default OtpService;
