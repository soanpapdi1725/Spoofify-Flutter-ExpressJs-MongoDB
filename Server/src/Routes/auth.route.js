import express from "express";

// controllers
import {
  postLogin,
  postSignup,
  sendUserData,
} from "../Controller/auth.controller.js";
const authRouter = express().router;

authRouter.post("/signup", postSignup);
authRouter.post("/login", postLogin);
authRouter.post("/", sendUserData);

export default authRouter;
