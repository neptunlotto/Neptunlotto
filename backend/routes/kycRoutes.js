const express = require("express");

const router = express.Router();

const {
  startKyc,
} = require("../controllers/kycController");


// ============================
// START KYC ROUTE
// ============================

router.post(
  "/start",
  startKyc
);


module.exports = router;