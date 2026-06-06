export function loginNotificationTemplate(name, email) {
  return `
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8" />
    <title>Login Alert</title>
  </head>
  <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
    <div style="max-width: 600px; margin: auto; background: #ffffff; padding: 30px; border-radius: 8px;">

      <h2 style="color: #333;">
        Login Successful 🔐
      </h2>

      <p>Hello <strong>${name}</strong>,</p>

      <p>
        Your account has been successfully logged in.
      </p>

      <div style="background: #f8f9fa; padding: 15px; border-radius: 6px; margin: 20px 0;">
        <p style="margin: 5px 0;">
          <strong>Email:</strong> ${email}
        </p>

        <p style="margin: 5px 0;">
          <strong>Time:</strong> ${new Date().toLocaleString()}
        </p>
      </div>

      <p>
        If this was you, no further action is required.
      </p>

      <p>
        If you do not recognize this login activity, please reset your password immediately and contact support.
      </p>

      <hr style="margin: 25px 0;" />

      <p style="font-size: 12px; color: #888;">
        This is an automated security notification.
      </p>

    </div>
  </body>
  </html>
  `;
}