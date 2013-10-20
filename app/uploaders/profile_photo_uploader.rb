class ProfilePhotoUploader < PhotoUploader
  version :icon do
    process :resize_to_fill => [50, 50]
  end

  version :thumb do
    process :crop
    # resize_to_fill(200, 200)
  end



  def crop
    if model.crop_x.present?
      manipulate! do |img|
        x = model.crop_x.to_i
        y = model.crop_y.to_i
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        img.crop!(x, y, w, h)
      end
      resize_to_fill(200, 200)
    end
  end

end