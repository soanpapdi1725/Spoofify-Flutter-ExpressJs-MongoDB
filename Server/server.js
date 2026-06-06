import express, { urlencoded } from "express";
import cors from "cors";
import { connectMongoDB } from "./src/Configs/databaseConfig.js";
import cookieParser from "cookie-parser";
import { sendResponse } from "./src/Utils/sendResponse.js";
import authRouter from "./src/Routes/auth.route.js";

const app = express();
const PORT = process.env.PORT || 4000;
await connectMongoDB();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

app.use((req, res, next) => {
  console.log("Method: ", req.method, "Path: ", req.path);
  next();
});

app.use("/api/v1/auth", authRouter);

app.get("/", (req, res) => {
  return sendResponse(res, 200, true, "Server working...");
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
