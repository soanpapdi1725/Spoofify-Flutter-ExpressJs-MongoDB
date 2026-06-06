import mongoose, { connect } from "mongoose";
import "dotenv/config";
export const connectMongoDB = async () => {
  try {
    await mongoose.connect(process.env.DATABASE_URI, {
      dbName: "Spoofify-Db",
    });
    console.log("MongoDB is connected");
  } catch (error) {
    console.log("MongoDB is not Connected");
    console.log(
      "Encountered with error while connecting with MongoDB: ",
      error.message,
    );
    process.exit(1);
  }
};
