import "dotenv/config";
import { sendResponse } from "../Utils/sendResponse.js";
import {
  uploadImageToCloudinary,
  uploadSongToCloudinary,
} from "../Utils/fileUploaderCloudinary.js";
import User from "../Model/User.model.js";
import Song from "../Model/Songs.model.js";

export const uploadSongController = async (req, res) => {
  try {
    // thumbnail and song will come from req.files
    const { thumbnail, song } = req.files;
    // song Name, artist name, hex_code come from req.body
    const { artistNames, songName, hexCode } = req.body;
    // checking if songName, artist and hex_code is not empty
    // if empty send response fields are empty
    const { id, email } = req.user;
    if (!artistNames || !songName || !hexCode) {
      return sendResponse(res, 400, false, "Fields are Empty");
    }
    if(!thumbnail || !song){
      return sendResponse(res, 400, false, "Song And Thumbnail are required")
    }
    // check user id exist in database or not if not then return that user does not exist
    const isUserExist = await User.findById(id);
    if (!isUserExist) {
      return sendResponse(res, 404, false, "User does not exist");
    }
    // if not then send thumbnail and song to cloudinary and get the response
    const thumbnailUploaded = await uploadImageToCloudinary(
      thumbnail,
      process.env.CLOUDINARY_THUMBNAIL_FOLDER,
    );
    const songUploaded = await uploadSongToCloudinary(
      song,
      process.env.CLOUDINARY_SONG_FOLDER,
    );
    // save that response's secureUrl and public Id(both song and thumbnail) in database
    const newSongAdded = await Song.create({
      songName: songName,
      artistNames: artistNames,
      hexCode: hexCode,
      thumbnail_url: thumbnailUploaded.secure_url,
      thumbnail_publicId: thumbnailUploaded.public_id,
      song_url: songUploaded.secure_url,
      song_publicId: songUploaded.public_id,
    });
    // then save database Response's objectId to User's Song
    const userUpdated = await User.findByIdAndUpdate(
      { _id: isUserExist._id },
      {
        $push: {
          addedSongs: newSongAdded._id,
        },
      },
      { new: true },
    ).populate("addedSongs");

    userUpdated.password = undefined;
    // send response
    return res.status(200).json({
      success: true,
      message: "Song Added successfully",
      data: userUpdated,
    });
  } catch (error) {
    // error message if any error occurs
    console.log("ERROR WHILE ADDING SONG", error);
    return sendResponse(
      res,
      500,
      false,
      "Failed To Add Song... please try again",
    );
  }
};
