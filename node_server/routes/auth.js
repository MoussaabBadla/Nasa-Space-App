import express from "express"
import { createUser, signin, tokenRefresh } from "../controllers/auth.js";

const router = express.Router();

router.post("/signup", createUser);
router.post("/login", signin);
router.post("/token",tokenRefresh);

export default router;

