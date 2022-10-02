import jwt from "jsonwebtoken";
import User from "../models/User.js";

export async function isAuthenthicated(req, res, next) {
  try {
    const token = req.headers.authorization;
    if (!token)
      return res
        .status(401)
        .json({ seccess: false, message: "user not authenticated" });

    const verify = jwt.verify(token, process.env.JWT_SECRET);
    if (!verify)
      return res.status(444).json({ seccess: false, message: "unvalid token" });

    const user = await User.findById(verify);
    if (!user){
      return res
        .status(404)
        .json({ seccess: false, message: "user not found" });
    }
  
    req.user = user;
    next();
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: error.message, success: false });
  }
}
