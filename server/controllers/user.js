const client = require("../services/client.js");

const store_data = async (req, res) => {
  try {
    const {
      uid,
      username,
      email,
      fullName,
      phoneNumber,
      dateOfBirth,
      gender,
      bio,
      profileImageURL,
      isBusinessProfile,
    } = req.body;

    if (!uid) {
      return res.status(400).json({ error: "uid is required" });
    }

    await client.hSet(`user:${uid}`, {
      uid,
      username,
      email,
      fullName,
      phoneNumber,
      dateOfBirth,
      gender,
      bio,
      profileImageURL,
      isBusinessProfile: Boolean(isBusinessProfile).toString(),
    });

    res.json({ message: "User data stored in Redis" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

const update_data = async (req, res) => {
  try {
    const {
      uid,
      username,
      email,
      fullName,
      phoneNumber,
      dateOfBirth,
      gender,
      bio,
      profileImageUrl,
      isBusinessProfile
    } = req.body;

    if (!uid) {
      return res.status(400).json({ error: "uid is required" });
    }

    const updates = {};
    if (username !== undefined) updates.username = username;
    if (email !== undefined) updates.email = email;
    if (fullName !== undefined) updates.fullName = fullName;
    if (phoneNumber !== undefined) updates.phoneNumber = phoneNumber;
    if (dateOfBirth !== undefined) updates.dateOfBirth = dateOfBirth;
    if (gender !== undefined) updates.gender = gender;
    if (bio !== undefined) updates.bio = bio;
    if (profileImageUrl !== undefined)
      updates.profileImageURL = profileImageUrl;
    if (isBusinessProfile !== undefined)
      updates.isBusinessProfile = Boolean(isBusinessProfile).toString();

    if (Object.keys(updates).length === 0) {
      return res.status(400).json({ error: "No fields to update" });
    }

    await client.hSet(`user:${uid}`, updates);

    res.json({ message: "User data updated in Redis" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

const delete_data = async (req, res) => {
  try {
    const { uid } = req.body;
    if (!uid) {
      return res.status(400).json({ error: "uid is required" });
    }

    await client.del(`user:${uid}`);
    res.json({ message: "User data deleted from Redis" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = { store_data, delete_data, update_data };
