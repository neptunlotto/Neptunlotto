const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const crypto = require("crypto");
const db = require("./config/db");
const nodemailer = require("nodemailer");

// ============================
// EMAIL CONFIGURATION
// ============================

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS
  }
});

// ============================
// SIGN IN API
// ============================

async function signIn(req, res) {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({
        message: "Email and password are required"
      });
    }

    const query = "SELECT * FROM users WHERE email = ?";

    db.query(query, [email], async (err, results) => {
      if (err) {
        console.error("Sign in database error:", err.message);

        return res.status(500).json({
          message: "Server error"
        });
      }

      if (results.length === 0) {
        return res.status(401).json({
          message: "Invalid email or password"
        });
      }

      const user = results[0];

      if (user.email_verified !== 1) {
        return res.status(403).json({
          message: "Please verify your email before signing in."
        });
      }

      const passwordMatches = await bcrypt.compare(
        password,
        user.password
      );

      if (!passwordMatches) {
        return res.status(401).json({
          message: "Invalid email or password"
        });
      }

      const token = jwt.sign(
        {
          userId: user.id,
          email: user.email
        },
        process.env.JWT_SECRET,
        {
          expiresIn: "7d"
        }
      );

      return res.status(200).json({
        message: "Signed in successfully",
        token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email,
          mobile: user.mobile,
          kyc_status: user.kyc_status
        }
      });
    });

  } catch (error) {
    console.error("Sign in error:", error);

    return res.status(500).json({
      message: "Server error"
    });
  }
}

// ============================
// RESET EMAIL TEMPLATE
// ============================

function buildResetEmail(name, resetLink) {
  const subject = "NEPTUN LOTTO - Reset your password";

  const text =
    `Hi ${name},\n\n` +
    `We received a request to reset your NEPTUN LOTTO password.\n\n` +
    `Reset your password using this link. The link is valid for 30 minutes:\n` +
    `${resetLink}\n\n` +
    `If you didn't request this, you can safely ignore this email.\n\n` +
    `— NEPTUN LOTTO`;

  const html = `
    <div style="font-family: Arial, Helvetica, sans-serif; background-color: #0d0d0d; padding: 32px 0;">
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center">
            <table
              role="presentation"
              width="480"
              cellpadding="0"
              cellspacing="0"
              style="background-color: #1a1a1a; border: 1px solid #2c2c2c; border-radius: 8px; overflow: hidden;"
            >

              <tr>
                <td
                  style="background-color: #111111; padding: 24px 32px; text-align: center; border-bottom: 1px solid #2c2c2c;"
                >
                  <span
                    style="color: #f2c94c; font-size: 20px; font-weight: bold; letter-spacing: 1px;"
                  >
                    NEPTUN LOTTO
                  </span>
                </td>
              </tr>

              <tr>
                <td style="padding: 32px; color: #e6e6e6;">

                  <h2
                    style="margin: 0 0 16px; font-size: 18px; color: #ffffff;"
                  >
                    Reset your password
                  </h2>

                  <p
                    style="margin: 0 0 16px; font-size: 14px; line-height: 1.6; color: #cccccc;"
                  >
                    Hi ${name},
                  </p>

                  <p
                    style="margin: 0 0 24px; font-size: 14px; line-height: 1.6; color: #cccccc;"
                  >
                    We received a request to reset the password on your
                    NEPTUN LOTTO account. Click the button below to choose
                    a new one. This link expires in
                    <strong>30 minutes</strong>.
                  </p>

                  <table role="presentation" cellpadding="0" cellspacing="0">
                    <tr>
                      <td
                        align="center"
                        style="border-radius: 6px; background-color: #f2c94c;"
                      >
                        <a
                          href="${resetLink}"
                          style="display: inline-block; padding: 12px 28px; font-size: 14px; font-weight: bold; color: #111111; text-decoration: none; border-radius: 6px;"
                        >
                          Reset Password
                        </a>
                      </td>
                    </tr>
                  </table>

                  <p
                    style="margin: 24px 0 0; font-size: 12px; line-height: 1.6; color: #888888;"
                  >
                    If the button doesn't work, copy and paste this link
                    into your browser:<br />
                    <a
                      href="${resetLink}"
                      style="color: #f2c94c; word-break: break-all;"
                    >
                      ${resetLink}
                    </a>
                  </p>

                  <p
                    style="margin: 24px 0 0; font-size: 12px; line-height: 1.6; color: #888888;"
                  >
                    If you didn't request this, you can safely ignore this
                    email — your password will not be changed.
                  </p>

                </td>
              </tr>

              <tr>
                <td
                  style="padding: 16px 32px; background-color: #111111; text-align: center; border-top: 1px solid #2c2c2c;"
                >
                  <span style="font-size: 11px; color: #666666;">
                    &copy; NEPTUN LOTTO. This is an automated message — please do not reply.
                  </span>
                </td>
              </tr>

            </table>
          </td>
        </tr>
      </table>
    </div>
  `;

  return {
    subject,
    text,
    html
  };
}

// ============================
// FORGOT PASSWORD
// SEND RESET LINK
// ============================

async function forgotPassword(req, res) {
  try {
    const { email } = req.body;

    if (!email) {
      return res.status(400).json({
        message: "Email is required"
      });
    }

    // Same response whether email exists or not
    const genericResponse = () => {
      return res.status(200).json({
        message:
          "If an account with that email exists, a password reset link has been sent."
      });
    };

    const findUserQuery =
      "SELECT id, name, email FROM users WHERE email = ?";

    db.query(
      findUserQuery,
      [email],
      (err, results) => {
        if (err) {
          console.error(
            "Forgot password: find user error:",
            err.message
          );

          return genericResponse();
        }

        // Don't reveal whether account exists
        if (results.length === 0) {
          return genericResponse();
        }

        const user = results[0];

        // Generate secure random token
        const rawToken =
          crypto.randomBytes(32).toString("hex");

        // Store only token hash in database
        const tokenHash =
          crypto
            .createHash("sha256")
            .update(rawToken)
            .digest("hex");

        // Token valid for 30 minutes
        const expiry =
          new Date(Date.now() + 30 * 60 * 1000);

        const updateTokenQuery = `
          UPDATE users
          SET
            reset_token_hash = ?,
            reset_token_expiry = ?
          WHERE email = ?
        `;

        db.query(
          updateTokenQuery,
          [tokenHash, expiry, email],
          (updateErr) => {
            if (updateErr) {
              console.error(
                "Forgot password: update token error:",
                updateErr.message
              );

              return genericResponse();
            }

            // Frontend URL
            const frontendUrl =
              process.env.FRONTEND_URL ||
              "http://localhost:5173";

            // Reset link
            const resetLink =
              `${frontendUrl}/reset-password?token=${rawToken}&email=${encodeURIComponent(email)}`;

            const {
              subject,
              text,
              html
            } = buildResetEmail(
              user.name,
              resetLink
            );

            transporter.sendMail(
              {
                from: process.env.EMAIL_USER,
                to: email,
                subject,
                text,
                html
              },
              (mailErr, info) => {
                if (mailErr) {
                  console.error(
                    "Forgot password: email send failed:",
                    mailErr.message
                  );
                } else {
                  console.log(
                    "Password reset email sent:",
                    info.response
                  );
                }

                return genericResponse();
              }
            );
          }
        );
      }
    );

  } catch (error) {
    console.error(
      "Forgot password unexpected error:",
      error.message
    );

    return res.status(500).json({
      message:
        "Something went wrong. Please try again."
    });
  }
}

// ============================
// RESET PASSWORD
// ============================

async function resetPassword(req, res) {
  try {
    const {
      token,
      email,
      newPassword
    } = req.body;

    if (!token || !email || !newPassword) {
      return res.status(400).json({
        message:
          "Token, email and new password are required"
      });
    }

    if (newPassword.length < 8) {
      return res.status(400).json({
        message:
          "Password must be at least 8 characters"
      });
    }

    // Hash token received from frontend
    const tokenHash =
      crypto
        .createHash("sha256")
        .update(token)
        .digest("hex");

    const findUserQuery = `
      SELECT
        id,
        reset_token_hash,
        reset_token_expiry
      FROM users
      WHERE email = ?
    `;

    db.query(
      findUserQuery,
      [email],
      async (err, results) => {
        if (err) {
          console.error(
            "Reset password: find user error:",
            err.message
          );

          return res.status(500).json({
            message:
              "Something went wrong. Please try again."
          });
        }

        if (results.length === 0) {
          return res.status(400).json({
            message:
              "This reset link is invalid or has already been used."
          });
        }

        const user = results[0];

        // Check token
        if (
          !user.reset_token_hash ||
          user.reset_token_hash !== tokenHash
        ) {
          return res.status(400).json({
            message:
              "This reset link is invalid or has already been used."
          });
        }

        // Check expiry
        if (
          !user.reset_token_expiry ||
          new Date() >
            new Date(user.reset_token_expiry)
        ) {
          return res.status(400).json({
            message:
              "This reset link has expired. Please request a new one."
          });
        }

        try {
          // Hash new password
          const hashedPassword =
            await bcrypt.hash(
              newPassword,
              10
            );

          // Update password and clear token
          const updatePasswordQuery = `
            UPDATE users
            SET
              password = ?,
              reset_token_hash = NULL,
              reset_token_expiry = NULL
            WHERE email = ?
          `;

          db.query(
            updatePasswordQuery,
            [hashedPassword, email],
            (updateErr) => {
              if (updateErr) {
                console.error(
                  "Reset password: update password error:",
                  updateErr.message
                );

                return res.status(500).json({
                  message:
                    "Something went wrong. Please try again."
                });
              }

              return res.status(200).json({
                message:
                  "Password reset successful. You can now log in with your new password."
              });
            }
          );

        } catch (hashError) {
          console.error(
            "Reset password: hashing error:",
            hashError.message
          );

          return res.status(500).json({
            message:
              "Something went wrong. Please try again."
          });
        }
      }
    );

  } catch (error) {
    console.error(
      "Reset password unexpected error:",
      error.message
    );

    return res.status(500).json({
      message:
        "Something went wrong. Please try again."
    });
  }
}

// ============================
// EXPORT
// ============================

module.exports = {
  signIn,
  forgotPassword,
  resetPassword
};