import cloudinary from "cloudinary";

export const uploadImageToCloudinary = async (
  file,
  folder,
  height,
  quality,
) => {
  const options = { folder };
  if (height) {
    options.height = height;
  }
  if (quality) {
    options.quality = quality;
  }

  options.resource_type = "image";
  const imageUploaded = await cloudinary.v2.uploader.upload(
    file.tempFilePath,
    options,
  );
  return imageUploaded;
};

export const uploadSongToCloudinary = async (file, folder, quality) => {
  const options = { folder };
  if (quality) {
    options.quality = quality;
  }

  options.resource_type = "video";
  const songUploaded = await cloudinary.v2.uploader.upload(
    file.tempFilePath,
    options,
  );

  return songUploaded;
};
