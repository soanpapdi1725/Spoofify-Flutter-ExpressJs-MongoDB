import mongoose from "mongoose";

const songSchema = mongoose.Schema(
  {
    createdBy: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
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

songSchema.set("toJSON", {transform: (doc, ret)=> {
  ret.id = ret._id;
  delete ret._id;
  delete ret.__v
}})
export default mongoose.model("Song", songSchema);
