class CoverPhotoUploader < PhotoUploader
    process :resize_to_fill => [1302, 300]

  version :wide do
  	process :crop
  end

    def crop
    if model.crop_x.present?
      manipulate! do |img|

        x = model.crop_c_x.to_i
        y = model.crop_c_y.to_i 
        w = model.crop_c_w.to_i
        h = model.crop_c_h.to_i
        cropped_img = img.crop(x,y,w,h)
        destroy_image(img)
        new_img = cropped_img.resize_to_fill(1302,300)
      end
    end
  end

end