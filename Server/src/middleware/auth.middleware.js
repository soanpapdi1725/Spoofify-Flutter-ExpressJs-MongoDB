import jwt from "jsonwebtoken";
import "dotenv/config";
import { sendResponse } from "../Utils/sendResponse.js";

export const auth_middleware = async (req, res, next) => {
  try {
    console.log("worked");
    const authHeader = req.headers?.authorization;
    const token =
      (authHeader && authHeader?.startsWith("Bearer ")
        ? authHeader?.replace("Bearer ", "")
        : null) || req.body?.token;
    if (!token) {
      return sendResponse(res, 404, false, "Token not found");
    }
    try {
      const decode = jwt.verify(token, process.env.JWT_SECRET);
      req.user = decode;
      next();
    } catch (error) {
      return sendResponse(res, 401, false, "Token is invalid");
    }
  } catch (error) {
    console.log("Error while Authenticating Token:", error);
    return sendResponse(
      res,
      500,
      false,
      "Internal server error while authenticating token... Please Try Again",
    );
  }
};
