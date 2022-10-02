import express from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import "dotenv/config";


import connectDB from "./DB/connection.js";

//Routes import
import authRouter from "./routes/auth.js";
import userRouter from "./routes/user.js";


const app = express();
const PORT = process.env.PORT || 5000;
var corsOptions = {
  origin: "*",
};

app.use(cors(corsOptions));
app.use(express.json());
app.use(cookieParser());
app.use(express.urlencoded({ extended: true }));

//routing
app.use("/api/auth", authRouter);
app.use("/api/users", userRouter);

app.all("*", (req, res) => {
  res.status(400).send("unvalid route");
});

connectDB((err) => {
  if (!err) {
    app.listen(PORT, () => {
      console.log("App listening on port " + PORT);
    });
  }
});
