export function suspiciousLoginTemplate(name, email) {
  return `
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8" />
    <title>Security Alert</title>
  </head>
  <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
    <div style="max-width: 600px; margin: auto; background: #ffffff; padding: 30px; border-radius: 8px;">

      <h2 style="color: #d9534f;">
        Security Alert ⚠️
      </h2>

      <p>Hello <strong>${name}</strong>,</p>

      <p>
        We detected a login attempt on your account associated with:
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
        If this login attempt was made by you, you can safely ignore this email.
      </p>

      <p style="color: #d9534f; font-weight: bold;">
        If this was not you, we strongly recommend changing your password immediately to secure your account.
      </p>

      <div style="background: #fff3cd; border-left: 4px solid #ffc107; padding: 15px; margin: 20px 0;">
        <strong>Recommended Actions:</strong>
        <ul>
          <li>Change your account password immediately.</li>
          <li>Use a strong and unique password.</li>
          <li>Do not share your credentials with anyone.</li>
          <li>Contact support if you continue to receive unexpected login alerts.</li>
        </ul>
      </div>

      <p>
        Your account security is important to us.
      </p>

      <hr style="margin: 25px 0;" />

      <p style="font-size: 12px; color: #888;">
        This is an automated security notification. Please do not reply to this email.
      </p>

    </div>
  </body>
  </html>
  `;
}