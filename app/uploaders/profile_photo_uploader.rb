class ProfilePhotoUploader < PhotoUploader
  version :icon do
    process :resize_to_fill => [50, 50]
  end

  version :thumb do
    process :resize_to_fill => [200, 200]
  end
end