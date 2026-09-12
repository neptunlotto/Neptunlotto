const db = require("../config/db");

const {
  generateSumsubAccessToken,
} = require("../services/sumsubService");


// ============================
// START KYC
// ============================

const startKyc = async (req, res) => {

  try {

    const { userId } = req.body;


    // Check user ID
    if (!userId) {

      return res.status(400).json({

        message: "User ID is required"

      });

    }


    // ============================
    // CHECK USER IN DATABASE
    // ============================

    const checkUserQuery = `
      SELECT
        id,
        email_verified,
        kyc_status
      FROM users
      WHERE id = ?
    `;


    db.query(
      checkUserQuery,
      [userId],

      async (error, results) => {

        if (error) {

          console.error(
            "Database error:",
            error.message
          );

          return res.status(500).json({

            message: "Database error"

          });

        }


        // User not found
        if (results.length === 0) {

          return res.status(404).json({

            message: "User not found"

          });

        }


        const user = results[0];


        // ============================
        // CHECK EMAIL VERIFICATION
        // ============================

        if (user.email_verified !== 1) {

          return res.status(403).json({

            message:
              "Please verify your email before starting KYC"

          });

        }


        // ============================
        // GENERATE SUMSUB TOKEN
        // ============================

        const tokenData =
          await generateSumsubAccessToken(
            userId
          );


        // ============================
        // UPDATE KYC STATUS
        // ============================

        const updateQuery = `
          UPDATE users
          SET kyc_status = 'pending'
          WHERE id = ?
        `;


        db.query(
          updateQuery,
          [userId],

          (updateError) => {

            if (updateError) {

              console.error(
                "KYC update error:",
                updateError.message
              );

              return res.status(500).json({

                message:
                  "Failed to update KYC status"

              });

            }


            // Send token to frontend
            return res.status(200).json({

              message:
                "KYC started successfully",

              token:
                tokenData.token,

              userId: userId,

              kycStatus:
                "pending"

            });

          }

        );

      }

    );


  } catch (error) {

    console.error(
      "KYC start failed:",
      error.response?.data ||
      error.message
    );


    return res.status(500).json({

      message:
        "Failed to start KYC verification"

    });

  }

};


module.exports = {
  startKyc
};