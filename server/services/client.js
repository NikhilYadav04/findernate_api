const { createClient } = require("redis"); // destructure properly
require("dotenv").config();

const REDIS_PASSWORD = process.env.REDIS_PASSWORD;
const REDIS_HOST = process.env.REDIS_HOST;

const client = createClient({
  username: "default",
  password: REDIS_PASSWORD,
  socket: {
    host: REDIS_HOST,
    port: 11807,
  },
});

//* Optional: handle connection events
client.on("connect", () => console.log("🔌 Redis connected"));
client.on("error", (err) => console.error("❌ Redis error", err));

//* Connect the client
(async () => {
  try {
    await client.connect();
  } catch (err) {
    console.error("❗ Failed to connect to Redis:", err);
  }
})();

module.exports = client;
