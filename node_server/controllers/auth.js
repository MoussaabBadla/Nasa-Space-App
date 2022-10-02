import User from "../models/User.js";
import RefreshTokens from "../models/Token.js";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
 const TOKEN_MAX_AGE = "10m";
const REFRESH_MAX_AGE = "60d";
export async function createUser(req, res) {
  try {
    const { password } = req.body;
    const hachedpassword = await bcrypt.hash(password, 10);
    let user = new User({
      ...req.body,
      password: hachedpassword,
    });
    user = await user.save();
    let id = user._id;
    const token = jwt.sign({ id }, process.env.JWT_SECRET, {
      expiresIn: TOKEN_MAX_AGE,
    });
    const refershToken = jwt.sign({ id }, process.env.JWT_REFRESH, {
      expiresIn: REFRESH_MAX_AGE,
    });

    user.password = undefined;
    
    res
      .status(201)
      .json({ success: true, data: { ...user._doc, refershToken,token } });

    const refreshTokens = await RefreshTokens.findOne({ id });
    if (!refreshTokens)
      await RefreshTokens.create({ id, tokens: [refershToken] });
    else
      await RefreshTokens.updateOne(
        { id },
        { $push: { tokens: refershToken } }
      );
  } catch (error) {
    if (error.message.includes("E11000")) {
      return res.status(422).json({
        message: "This Email Already Used try with another email",
        success: false,
      });
    }

    res.status(500).json({ success: false, message: error.message });
  }
}

export async function signin(req, res) {
  try {
    const { email, password } = req.body;
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({
        message: "User with this email does not exist",
        success: false,
      });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res
        .status(400)
        .json({ message: "Incorrect password try again ! ", success: false });
    }

    let id = user._id;

    const token = jwt.sign({ id }, process.env.JWT_SECRET, {
      expiresIn: TOKEN_MAX_AGE,
    });
    const refershToken = jwt.sign({ id }, process.env.JWT_REFRESH, {
      expiresIn: REFRESH_MAX_AGE,
    });

    const refreshTokens = await RefreshTokens.findOne({ id });
    if (!refreshTokens) await RefreshTokens.create({ id, tokens: [token] });
    else await RefreshTokens.updateOne({ id }, { $push: { tokens: token } });

    user._doc.password = undefined;
    res
      .status(200)
      .json({ data: { refershToken, token, ...user._doc }, success: true });
  } catch (error) {
    res.status(500).json({ message: error.message, success: false });
  }
}

export async function tokenRefresh(req, res) {
  const token = req.headers.authorization;
  try {
    if (!token)
      return res.status(400).json({ success: false, message: "no token" });
    const verefiedToken = jwt.verify(token, process.env.JWT_REFRESH);
    const userTokens = await RefreshTokens.findOne({ id: verefiedToken.id });
    if (!userTokens?.tokens.includes(token))
      return res
        .status(403)
        .json({ success: false, message: "invalid refresh token" });

    const newToken = jwt.sign(verefiedToken.id, process.env.JWT_SECRET);
    return res.status(200).json({ success: true, data: { token: newToken , id : verefiedToken.id} });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message,
    });
    // cleaning the DB from expired tokens
    if (error.message == "jwt expired") {
      const { id } = jwt.decode(token);
      const tokenUser = await RefreshTokens.findOne({ id });
      if (tokenUser)
        RefreshTokens.updateOne(
          { id: tokenUser._id },
          { $pull: { tokens: token } }
        );
    }
  }
}
