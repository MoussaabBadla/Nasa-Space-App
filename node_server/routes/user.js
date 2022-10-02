// for get user data  , :D 

import express from "express"

import { getUser, addtofavorite as addToFavorite ,deletfromfavorite as deletFromFavorite } from "../controllers/user.js";
import { isAuthenthicated } from "../middlewares/authorization.js";

const userrouter = express.Router();

userrouter.get("/:id", isAuthenthicated, getUser);
userrouter.post('/addtofav/:id',isAuthenthicated,addToFavorite);
userrouter.post('/deletfromfav/:id',isAuthenthicated,deletFromFavorite);


export default userrouter;