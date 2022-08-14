const forgotPasswordTemplate = (url: string) => {
  return `<p>
    We have received your request for forgot your password.
    </p>
    <a href="${url}">
    Forgot password
    <a/>
    <p>
    This link is valid only for 10 minutes.
    </p>
    <p>
     If you did not request for forgot password, please ignore this email.
    </p>
    `;
};

export default forgotPasswordTemplate;
