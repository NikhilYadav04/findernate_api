const express = require("express");
const { send_otp, verify_otp } = require("../controllers/otp");
const otpRouter = express.Router();

otpRouter.use(express.json());

//* send otp via Twilio
otpRouter.post("/send-otp", send_otp);

//* Verify OTP
otpRouter.post("/verify-otp", verify_otp);

module.exports = otpRouter;
