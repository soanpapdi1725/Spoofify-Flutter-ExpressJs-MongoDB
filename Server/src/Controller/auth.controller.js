// External Modules
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
// Local modules
import { sendResponse } from "../Utils/sendResponse.js";
import User from "../Model/User.model.js";
import mailSender from "../Utils/mailSender.js";
import { accountCreatedTemplate } from "../Templates/Mail/AccountCreatedMailTemplate.js";
import { loginNotificationTemplate } from "../Templates/Mail/AccountLoggedIn.js";
import { suspiciousLoginTemplate } from "../Templates/Mail/SuspiciousLoginMail.js";
// Signup pages
export const postSignup = async (req, res) => {
  try {
    // get name, email, password from req ki body
    const { name, email, password } = req.body;
    // check are they not empty
    // if empty send response of bad request 400
    if (!name || !email || !password) {
      return sendResponse(res, 400, false, "Please Fill the Fields Properly");
    }
    // if not empty proceed
    // check email if from server is it exist or nots
    const userExist = await User.findOne({ email: email });
    // if exist then again send response that Your email id already exist please login directly
    if (userExist) {
      return sendResponse(res, 400, false, "User's Account Already Exists");
    }
    // if it does not exist split the name as like split(" ")
    const [firstName, ...rest] = name.split(" ");
    const lastName = rest.join(" ");
    // bcrypt his password
    const hashedPass = await bcrypt.hash(password, 12);
    // Save User in Database Call
    // payload which gonna save
    const userData = {
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: hashedPass,
    };
    const newUser = await User.create(userData);
    // and send mail
    // await mailSender(
    //   "Account Created Successfully",
    //   accountCreatedTemplate(firstName, email, password),
    //   email,
    // );
    // send response 200 and account creation message
    const payload = {
      email: email,
      id: newUser._id,
    };
    // sign jwt
    const token = await jwt.sign(payload, process.env.JWT_SECRET, {
      expiresIn: "30d",
    });
    const cookieOptions = {
      expires: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
      httpOnly: true,
    };
    // Send mail
    // await mailSender(
    //   "Account Logged In Successfully",
    //   loginNotificationTemplate(userExist.firstName, email),
    //   email,
    // );
    // Send Response with cookie and json -> not by function
    const userToSend = {
      id: newUser._id,
      firstName: newUser.firstName,
      lastName: newUser.lastName,
      email: newUser.email,
      token: token,
      createdAt: newUser.createdAt,
      updatedAt: newUser.updatedAt,
    };
    return res.cookie("token", token, cookieOptions).status(200).json({
      success: true,
      message: "User is Created And Logged in Successfully",
      data: userToSend,
    });
  } catch (error) {
    // error message if any error occurs
    console.log("ERROR WHILE SIGNING UP", error);
    return sendResponse(
      res,
      500,
      false,
      "Failed To Sign up... please try again",
    );
  }
};

// Login

export const postLogin = async (req, res) => {
  try {
    //get email and password from request ki body
    const { email, password } = req.body;
    // Check is it empty or not
    if (!email || !password) {
      return sendResponse(res, 400, false, "Field cannot be Empty");
    }
    // check email that does it exist or not in Database

    const userExist = await User.findOne({ email: email });
    // if not exist then tell users to create account first
    if (!userExist) {
      return sendResponse(res, 404, false, "User need to create account first");
    }
    // if user exist then compare password
    if (!(await bcrypt.compare(password, userExist.password))) {
      // await mailSender(
      //   "Someone Tried to Login Your Account",
      //   suspiciousLoginTemplate(userExist.firstName, email),
      //   email,
      // );
      return sendResponse(res, 400, false, "Incorrect User Crendentials");
    }
    //
    // make payload
    const payload = {
      email: email,
      id: userExist._id,
    };
    // sign jwt
    const token = await jwt.sign(payload, process.env.JWT_SECRET, {
      expiresIn: "30d",
    });
    const cookieOptions = {
      expires: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000),
      httpOnly: true,
    };
    // Send mail
    // await mailSender(
    //   "Account Logged In Successfully",
    //   loginNotificationTemplate(userExist.firstName, email),
    //   email,
    // );
    // Send Response with cookie and json -> not by function
    const userToSend = {
      id: userExist._id,
      firstName: userExist.firstName,
      lastName: userExist.lastName,
      email: userExist.email,
      token: token,
      createdAt: userExist.createdAt,
      updatedAt: userExist.updatedAt,
    };
    return res.cookie("token", token, cookieOptions).status(200).json({
      success: true,
      message: "User Logged in Successfully",
      data: userToSend,
    });
  } catch (error) {
    // error message if any error occurs
    console.log("ERROR WHILE LOGIN", error);
    return sendResponse(res, 500, false, "Failed To Login... please try again");
  }
};
