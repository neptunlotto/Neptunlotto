const bcrypt = require("bcryptjs");
const express = require("express");
const db = require("./config/db");
const nodemailer = require("nodemailer");
const twilio = require("twilio");
const kycRoutes = require("./routes/kycRoutes");
require("dotenv").config();


// ============================
// TWILIO CONFIGURATION
// ============================

const client = twilio(
  process.env.TWILIO_ACCOUNT_SID,
  process.env.TWILIO_AUTH_TOKEN
);


const app = express();

app.use(express.json());
app.use("/api/kyc", kycRoutes);


// ============================
// NODEMAILER CONFIGURATION
// ============================

const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS
  }
});




// ============================
// SIGNUP API
// ============================

app.post("/api/auth/signup", async (req, res) => {

  try {

    const {
      name,
      email,
      mobile,
      date_of_birth,
      password
    } = req.body;


    // Check required fields
    if (
      !name ||
      !email ||
      !mobile ||
      !date_of_birth ||
      !password
    ) {

      return res.status(400).json({

        message:
          "Name, email, mobile, date of birth and password are required"

      });

    }


    // Calculate age
    const birthDate =
      new Date(date_of_birth);

    const today =
      new Date();


    let age =
      today.getFullYear() -
      birthDate.getFullYear();


    const monthDifference =
      today.getMonth() -
      birthDate.getMonth();


    if (
      monthDifference < 0 ||
      (
        monthDifference === 0 &&
        today.getDate() <
        birthDate.getDate()
      )
    ) {

      age--;

    }


    // Check minimum age
    if (age < 18) {

      return res.status(400).json({

        message:
          "You must be at least 18 years old to register"

      });

    }


    // Generate Email OTP
    const otp =
      Math.floor(
        100000 +
        Math.random() * 900000
      ).toString();


    // Email OTP expiry: 10 minutes
    const otpExpiry =
      new Date(
        Date.now() +
        10 * 60 * 1000
      );


    // Check if email exists
    const checkEmailQuery =
      "SELECT * FROM users WHERE email = ?";


    db.query(
      checkEmailQuery,
      [email],
      async (err, results) => {

        if (err) {

          return res.status(500).json({

            message:
              err.message

          });

        }


        // Email already exists
        if (results.length > 0) {

          const existingUser =
            results[0];


          // Already verified
          if (
            existingUser.email_verified === 1
          ) {

            return res.status(400).json({

              message:
                "Email already registered. Please log in."

            });

          }


          // Not verified
          return res.status(400).json({

            message:
              "Email already registered. Please verify your email or resend OTP."

          });

        }


        try {

          // Hash password
          const hashedPassword =
            await bcrypt.hash(
              password,
              10
            );


          // Insert user
          const insertQuery = `
            INSERT INTO users
            (
              name,
              email,
              mobile,
              date_of_birth,
              password,
              email_otp,
              otp_expiry
            )
            VALUES (?, ?, ?, ?, ?, ?, ?)
          `;


          db.query(
            insertQuery,
            [
              name,
              email,
              mobile,
              date_of_birth,
              hashedPassword,
              otp,
              otpExpiry
            ],
            (err, result) => {

              if (err) {

                return res.status(500).json({

                  message:
                    err.message

                });

              }


              // Email configuration
              const mailOptions = {

                from:
                  process.env.EMAIL_USER,

                to:
                  email,

                subject:
                  "NEPTUN LOTTO - Email Verification OTP",

                text:
                  `Your OTP is ${otp}. ` +
                  `It will expire in 10 minutes.`

              };


              // Send email
              transporter.sendMail(
                mailOptions,
                (error, info) => {

                  if (error) {

                    console.error(
                      "Email sending failed:",
                      error.message
                    );

                    return res.status(500).json({

                      message:
                        "User registered, but OTP email could not be sent"

                    });

                  }


                  console.log(
                    "Email sent successfully:",
                    info.response
                  );


                  return res.status(201).json({

                    message:
                      "User registered successfully. OTP sent to your email.",

                    userId:
                      result.insertId

                  });

                }
              );

            }
          );


        } catch (error) {

          console.error(error);

          return res.status(500).json({

            message:
              "Password hashing error"

          });

        }

      }
    );


  } catch (error) {

    console.error(error);

    return res.status(500).json({

      message:
        "Server error"

    });

  }

});


// ============================
// VERIFY EMAIL OTP API
// ============================

app.post(
  "/api/auth/verify-otp",
  (req, res) => {

    const {
      email,
      otp
    } = req.body;


    // Check email and OTP
    if (!email || !otp) {

      return res.status(400).json({

        message:
          "Email and OTP are required"

      });

    }


    // Find user
    const query =
      "SELECT * FROM users WHERE email = ?";


    db.query(
      query,
      [email],
      (err, results) => {

        if (err) {

          return res.status(500).json({

            message:
              err.message

          });

        }


        // User not found
        if (results.length === 0) {

          return res.status(404).json({

            message:
              "User not found"

          });

        }


        const user =
          results[0];


        // Already verified
        if (user.email_verified === 1) {

          return res.status(400).json({

            message:
              "Email is already verified"

          });

        }


        // OTP expired
        if (
          !user.otp_expiry ||
          new Date() >
          new Date(user.otp_expiry)
        ) {

          return res.status(400).json({

            message:
              "OTP has expired. Please request a new OTP."

          });

        }


        // Check OTP
        if (user.email_otp !== otp) {

          return res.status(400).json({

            message:
              "Invalid OTP"

          });

        }


        // Verify email
        const updateQuery = `
          UPDATE users
          SET
            email_verified = 1,
            email_otp = NULL,
            otp_expiry = NULL
          WHERE email = ?
        `;


        db.query(
          updateQuery,
          [email],
          (err) => {

            if (err) {

              return res.status(500).json({

                message:
                  err.message

              });

            }


            return res.status(200).json({

              message:
                "Email verified successfully"

            });

          }
        );

      }
    );

  }
);


// ============================
// RESEND EMAIL OTP API
// ============================

app.post(
  "/api/auth/resend-otp",
  (req, res) => {

    const {
      email
    } = req.body;


    // Check email
    if (!email) {

      return res.status(400).json({

        message:
          "Email is required"

      });

    }


    // Find user
    const findUserQuery =
      "SELECT * FROM users WHERE email = ?";


    db.query(
      findUserQuery,
      [email],
      (err, results) => {

        if (err) {

          return res.status(500).json({

            message:
              err.message

          });

        }


        // User not found
        if (results.length === 0) {

          return res.status(404).json({

            message:
              "User not found. Please sign up first."

          });

        }


        const user =
          results[0];


        // Already verified
        if (user.email_verified === 1) {

          return res.status(400).json({

            message:
              "Email is already verified"

          });

        }


        // Generate new OTP
        const newOtp =
          Math.floor(
            100000 +
            Math.random() * 900000
          ).toString();


        // New expiry
        const newOtpExpiry =
          new Date(
            Date.now() +
            10 * 60 * 1000
          );


        // Update OTP
        const updateOtpQuery = `
          UPDATE users
          SET
            email_otp = ?,
            otp_expiry = ?
          WHERE email = ?
        `;


        db.query(
          updateOtpQuery,
          [
            newOtp,
            newOtpExpiry,
            email
          ],
          (err) => {

            if (err) {

              return res.status(500).json({

                message:
                  err.message

              });

            }


            const mailOptions = {

              from:
                process.env.EMAIL_USER,

              to:
                email,

              subject:
                "NEPTUN LOTTO - New OTP",

              text:
                `Your new OTP is ${newOtp}. ` +
                `It will expire in 10 minutes.`

            };


            // Send new OTP
            transporter.sendMail(
              mailOptions,
              (error, info) => {

                if (error) {

                  console.error(
                    "Email sending failed:",
                    error.message
                  );

                  return res.status(500).json({

                    message:
                      "New OTP could not be sent"

                  });

                }


                console.log(
                  "New OTP sent successfully:",
                  info.response
                );


                return res.status(200).json({

                  message:
                    "New OTP sent successfully"

                });

              }
            );

          }
        );

      }
    );

  }
);


// ============================
// SEND SMS OTP API
// ============================

app.post(
  "/api/auth/send-sms-otp",
  async (req, res) => {

    try {

      const {
        mobile
      } = req.body;


      // Check mobile number
      if (!mobile) {

        return res.status(400).json({

          message:
            "Mobile number is required"

        });

      }


      // Send OTP using Twilio Verify
      const verification =
        await client.verify.v2
          .services(
            process.env.TWILIO_VERIFY_SERVICE_SID
          )
          .verifications
          .create({

            to: mobile,
            channel: "sms"

          });


      return res.status(200).json({

        message:
          "OTP sent successfully to your mobile number",

        status:
          verification.status

      });


    } catch (error) {

      console.error(
        "SMS OTP sending failed:",
        error.message
      );


      return res.status(500).json({

        message:
          "Failed to send SMS OTP"

      });

    }

  }
);


// ============================
// VERIFY SMS OTP API
// ============================

app.post(
  "/api/auth/verify-sms-otp",
  async (req, res) => {

    try {

      const {
        mobile,
        otp
      } = req.body;


      // Check required fields
      if (!mobile || !otp) {

        return res.status(400).json({

          message:
            "Mobile number and OTP are required"

        });

      }


      // Verify OTP with Twilio
      const verificationCheck =
        await client.verify.v2
          .services(
            process.env.TWILIO_VERIFY_SERVICE_SID
          )
          .verificationChecks
          .create({

            to:
              mobile,

            code:
              otp

          });


      // OTP approved
      if (
        verificationCheck.status ===
        "approved"
      ) {

        return res.status(200).json({

          message:
            "Mobile number verified successfully",

          status:
            verificationCheck.status

        });

      }


      // OTP invalid
      return res.status(400).json({

        message:
          "Invalid or expired OTP",

        status:
          verificationCheck.status

      });


    } catch (error) {

      console.error(
        "SMS OTP verification failed:",
        error.message
      );


      return res.status(500).json({

        message:
          "Failed to verify SMS OTP"

      });

    }

  }
);


// ============================
// RESEND SMS OTP API
// ============================

app.post(
  "/api/auth/resend-sms-otp",
  async (req, res) => {

    try {

      const {
        mobile
      } = req.body;


      // Check mobile number
      if (!mobile) {

        return res.status(400).json({

          message:
            "Mobile number is required"

        });

      }


      // Request new OTP from Twilio
      const verification =
        await client.verify.v2
          .services(
            process.env.TWILIO_VERIFY_SERVICE_SID
          )
          .verifications
          .create({

            to:
              mobile,

            channel:
              "sms"

          });


      return res.status(200).json({

        message:
          "New OTP sent successfully",

        status:
          verification.status

      });


    } catch (error) {

      console.error(
        "SMS OTP resend failed:",
        error.message
      );


      return res.status(500).json({

        message:
          "Failed to resend SMS OTP"

      });

    }

  }
);


// ============================
// TEST API
// ============================

app.get("/", (req, res) => {

  res.json({

    message:
      "NEPTUN LOTTO Backend is running!"

  });

});


// ============================
// SERVER
// ============================

const PORT = 5000;

app.listen(PORT, () => {

  console.log(
    `Server is running on port ${PORT}`
  );

});