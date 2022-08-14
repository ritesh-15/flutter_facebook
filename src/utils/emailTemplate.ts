export const emailTemplate = (code: string) => {
  return `
    <p>
        Your one time verification code is <strong>${code}</strong>.
        Use this code to verify your account.
    </p>
    `;
};
