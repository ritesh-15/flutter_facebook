import sgMail from "@sendgrid/mail";
import { SEND_GRID_API_KEY, SEND_GRID_EMAIL } from "../constants/secrets";

export interface MailOptions {
  to: string;
  subject: string;
  text: string;
  html?: string;
}

export const sendEmail = ({ to, subject, text, html }: MailOptions) => {
  sgMail.setApiKey(SEND_GRID_API_KEY);

  const options = {
    to: [to],
    from: {
      name: "Facebook",
      email: SEND_GRID_EMAIL,
    },
    subject,
    text,
    html,
  };

  return sgMail.send(options);
};
