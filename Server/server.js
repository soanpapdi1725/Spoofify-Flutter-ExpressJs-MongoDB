import express from "express";
import cors from "cors";
import cookieParser from "cookie-parser";
import fileUpload from "express-fileupload";
import os from "os";
import { connectMongoDB } from "./src/Configs/databaseConfig.js";
import { cloudinaryConnect } from "./src/Configs/cloudinary.config.js";
import { sendResponse } from "./src/Utils/sendResponse.js";
import authRouter from "./src/Routes/auth.route.js";
import songRouter from "./src/Routes/song.route.js";

const app = express();
const PORT = process.env.PORT || 4000;

await connectMongoDB();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());

app.use(fileUpload({ useTempFiles: true, tempFileDir: "/temp/" }));
await cloudinaryConnect();
app.use((req, res, next) => {
  console.log("Method: ", req.method, "Path: ", req.path);
  next();
});
// auth routes
app.use("/api/v1/auth", authRouter);
// song Routes
app.use("/api/v1/song", songRouter);

app.get("/", (req, res) => {
  return sendResponse(res, 200, true, "Server working...");
});
const interfaces = os.networkInterfaces();
for (const name of Object.keys(interfaces)) {
  for (const connections of interfaces[name]) {
    if (connections.family === "IPv4" && !connections.internal) {
      console.log("IPv4 Address:", connections.address);
    }
  }
}
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
