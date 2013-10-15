class CoverPhotoUploader < PhotoUploader
  version :wide do
    process :resize_to_fill => [1302, 300]
  end
end