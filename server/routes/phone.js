const express = require("express");
const { store_phone, check_phone } = require("../controllers/phone");
const phoneRouter = express.Router();

//* Route 1: Store phone→ email
phoneRouter.post("/store-phone", store_phone);

//* Route 2: Check phone→ get email
phoneRouter.get("/check/:phone", check_phone);

module.exports = phoneRouter;
