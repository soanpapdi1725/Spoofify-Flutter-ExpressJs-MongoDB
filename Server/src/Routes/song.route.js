import express from "express";
import { auth_middleware } from "../middleware/auth.middleware.js";
import { uploadSongController } from "../Controller/song.controller.js";

const songRouter = express.Router();

songRouter.post("/upload", auth_middleware, uploadSongController);

export default songRouter;
