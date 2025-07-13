const express = require("express");
const { check, store } = require("../controllers/username");
const usernameRouter = express.Router();

//* Route 1: Store username → email
usernameRouter.post("/store-username", store);

//* Route 2: Check username → get email
usernameRouter.get("/check/:username", check);

module.exports = usernameRouter;
