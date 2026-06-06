export function accountCreatedTemplate(name, email, password) {
  return `
  <!DOCTYPE html>
  <html>
  <head>
    <meta charset="UTF-8" />
    <title>Account Created</title>
  </head>
  <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px;">
    <div style="max-width: 600px; margin: auto; background: #ffffff; border-radius: 8px; padding: 30px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
      
      <h2 style="color: #333;">Welcome, ${name}! 🎉</h2>
      
      <p style="font-size: 16px; color: #555;">
        Your account has been successfully created. You can use the following credentials to log in:
      </p>

      <div style="background: #f8f9fa; padding: 15px; border-radius: 6px; margin: 20px 0;">
        <p style="margin: 8px 0;">
          <strong>Email:</strong> ${email}
        </p>

        <p style="margin: 8px 0;">
          <strong>Password:</strong> ${password}
        </p>
      </div>

      <p style="font-size: 14px; color: #666;">
        For security reasons, we recommend changing your password after your first login.
      </p>

      <p style="font-size: 14px; color: #666;">
        If you did not request this account, please contact support immediately.
      </p>

      <hr style="margin: 25px 0;" />

      <p style="font-size: 12px; color: #999;">
        © ${new Date().getFullYear()} Your Company. All rights reserved.
      </p>
    </div>
  </body>
  </html>
  `;
}