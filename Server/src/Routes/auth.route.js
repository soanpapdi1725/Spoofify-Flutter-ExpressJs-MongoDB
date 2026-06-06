import express from "express";

// controllers
import { postLogin, postSignup } from "../Controller/auth.controller.js";
const authRouter = express().router;

authRouter.post("/signup", postSignup);
authRouter.post("/login", postLogin);

export default authRouter;
