const axios = require("axios");

const crypto = require("crypto");


// ============================
// SUMSUB CONFIGURATION
// ============================

const SUMSUB_BASE_URL =
  "https://api.sumsub.com";


// ============================
// CREATE SUMSUB SIGNATURE
// ============================

function createSignature(
  method,
  path,
  body = ""
) {

  const timestamp =
    Math.floor(Date.now() / 1000);


  const data =
    timestamp +
    method.toUpperCase() +
    path +
    body;


  const signature =
    crypto
      .createHmac(

        "sha256",

        process.env.SUMSUB_SECRET_KEY

      )

      .update(data)

      .digest("hex");


  return {

    timestamp,

    signature

  };

}


// ============================
// GENERATE SUMSUB ACCESS TOKEN
// ============================

async function generateSumsubAccessToken(
  userId
) {

  try {

    const path =
      `/resources/accessTokens` +
      `?userId=${encodeURIComponent(userId)}` +
      `&levelName=${encodeURIComponent(process.env.SUMSUB_LEVEL_NAME)}` +
      `&ttlInSecs=600`;


    const method = "POST";

    const body = "";


    const {
      timestamp,
      signature
    } = createSignature(
      method,
      path,
      body
    );


    const response =
      await axios.post(

        `${SUMSUB_BASE_URL}${path}`,

        body,

        {

          headers: {

            "X-App-Token":
              process.env.SUMSUB_APP_TOKEN,

            "X-App-Access-Ts":
              timestamp,

            "X-App-Access-Sig":
              signature,

            "Content-Type":
              "application/json"

          }

        }

      );


    return response.data;


  } catch (error) {

    console.error(

      "Sumsub API error:",

      error.response?.data ||
      error.message

    );


    throw error;

  }

}


module.exports = {

  generateSumsubAccessToken

};