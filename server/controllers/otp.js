const twilioClient = require("../services/twilio");

require("dotenv").config();

const verifyServiceSid = process.env.TWILIO_VERIFY_SERVICE_SID;

const send_otp = async (req, res) => {
  const { phoneNumber } = req.body;
  try {
    //* send otp
    const verification = await twilioClient.verify.v2
      .services(verifyServiceSid)
      .verifications.create({
        to: `+91${phoneNumber}`,
        channel: "sms",
      });

    return res.status(200).json({
      success: true,
      sid: verification.sid,
      message: "OTP sent successfully",
    });
  } catch (err) {
    console.error("Twilio Verify Error:", err);
    return res.status(500).json({
      success: false,
      message: err.message,
    });
  }
};

const verify_otp = async (req, res) => {
  try {
    const { otp, phoneNumber } = req.body;

    const verificationCheck = await twilioClient.verify.v2
      .services(verifyServiceSid)
      .verificationChecks.create({
        code: otp,
        to: `+91${phoneNumber}`,
      });

    if (verificationCheck.status === "approved") {
      return res.status(200).json({
        success: true,
        message: "OTP Verified Successfully",
      });
    } else {
      return res.status(400).json({
        success: false,
        message: "OTP is Invalid or Expired",
      });
    }
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to fetch data", details: error.message });
  }
};

module.exports = { send_otp, verify_otp };
