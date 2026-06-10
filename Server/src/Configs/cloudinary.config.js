import cloudinary from "cloudinary";
import "dotenv/config";

export const cloudinaryConnect = async () => {
  try {
    await cloudinary.v2.config({
      cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
      api_key: process.env.CLOUDINARY_API_KEY,
      api_secret: process.env.CLOUDINARY_API_SECRET,
      secure: true,
    });
    console.log("Cloudinary Connected");
  } catch (error) {
    console.log("Cloudinary Connected: ", error);
  }
};
