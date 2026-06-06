import mongoose from "mongoose";

const userSchema = mongoose.Schema(
  {
    firstName: { type: String, required: true, trim: true },
    lastName: { type: String, trim: true },
    email: { type: String, required: true, trim: true },
    password: { type: String, required: true },
  },

  { timestamps: true },
);

export default mongoose.model("User", userSchema);
