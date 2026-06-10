import mongoose from "mongoose";

const songSchema = mongoose.Schema(
  {
    songName: { type: String, required: true },
    artistNames: { type: String, required: true },
    hexCode: { type: String, required: true },
    thumbnail_url: { type: String, required: true },
    thumbnail_publicId: { type: String, required: true },
    song_url: { type: String, required: true },
    song_publicId: { type: String, required: true },
  },
  { timestamps: true },
);

export default mongoose.model("Song", songSchema);
