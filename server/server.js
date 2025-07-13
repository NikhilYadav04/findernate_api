const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const morgan = require("morgan");
const { router1 } = require("./route_config/router.js");
const usernameRouter = require("./routes/username.js");
const phoneRouter = require("./routes/phone.js");
const otpRouter = require("./routes/otp.js");
const userRouter = require("./routes/user.js");

const app = express();
const PORT = 3000;

app.get("/", (req, res) => {
  res.send("Hello from Redis And Node JS");
});

//* Middlewares
app.use(cors());
app.use(morgan("dev"));

app.use(bodyParser.json());
app.use(express.json());
app.use(router1);

//* Routes
router1.use("/api/username", usernameRouter);
router1.use("/api/phone", phoneRouter);
router1.use("/api/otp", otpRouter);
router1.use("/api/user", userRouter);

app.listen(PORT, () => {
  console.log(`🚀 Server is running at http://localhost:${PORT}`);
});
