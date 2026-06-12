import express from "express";
import { auth_middleware } from "../middleware/auth.middleware.js";
import {
  getSongList,
  uploadSongController,
} from "../Controller/song.controller.js";

const songRouter = express.Router();

songRouter.post("/upload", auth_middleware, uploadSongController);
songRouter.get("/All_list", auth_middleware, getSongList);
export default songRouter;
