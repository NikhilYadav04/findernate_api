const client = require("../services/client.js");


const store_phone = async (req, res) => {
  const { phone, email } = req.body;

  if (!phone || !email) {
    return res.status(400).json({ error: "Phone and Email are required." });
  }

  try {
    await client.hSet("phone", phone, email);
    res.json({ message: "Stored successfully" });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to store data", details: error.message });
  }
};

const check_phone = async (req, res) => {
  const phone = req.params.phone;

  try {
    const email = await client.hGet("phone", phone);

    if (!email) {
      return res.status(404).json({ message: "Phone not found" });
    }

    res.json({ phone, email });
  } catch (error) {
    res
      .status(500)
      .json({ error: "Failed to fetch data", details: error.message });
  }
};

module.exports = { check_phone, store_phone };