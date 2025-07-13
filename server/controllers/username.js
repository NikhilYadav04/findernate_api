const client = require("../services/client.js");


const store = async (req, res) => {
  const { email, username } = req.body;

  if (!email || !username) {
    return res.status(400).json({ error: "Email and username are required." });
  }

  try {
    await client.hSet("usernames", username, email);
    res.json({ message: "Stored successfully" });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to store data", details: error.message });
  }
};

const check = async (req, res) => {
  const username = req.params.username;

  try {
    const email = await client.hGet("usernames", username);

    if (!email) {
      return res.status(404).json({ message: "Username not found" });
    }

    res.json({ username, email });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to fetch data", details: error.message });
  }
};

module.exports = { check, store };
