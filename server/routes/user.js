const express = require("express");
const {
  delete_data,
  store_data,
  update_data,
} = require("../controllers/user.js");
const client = require("../services/client.js");
const userRouter = express.Router();

//* store user data in redis
userRouter.post("/store-data", store_data);

//* edit data
userRouter.post("/update-data", update_data);

//* erase user data from redis
userRouter.post("/delete-data", delete_data);

//* get user data from redis
userRouter.get("/get-data/:uid", async (req, res) => {
  try {
    const { uid } = req.params;
    if (!uid) {
      return res.status(400).json({ error: "uid is required" });
    }

    const userData = await client.hGetAll(`user:${uid}`);
    if (!userData || Object.keys(userData).length === 0) {
      return res.status(404).json({ error: "User not found in Redis" });
    }

    if (userData.isBusinessProfile !== undefined) {
      userData.isBusinessProfile = userData.isBusinessProfile === "true";
    }

    res.json({ user: userData });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = userRouter;
