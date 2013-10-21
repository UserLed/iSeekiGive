class ProfilePhotoUploader < PhotoUploader
  process :resize_to_fill => [200, 200]

  version :icon do
    process :resize_to_fill => [50, 50]
  end

  version :thumb do
    # resize_to_fill(200,200)
    process :crop
    process :resize_to_fill => [200, 200]
    #process :get_geometry 

  end

  def get_geometry 
    if (@file) 
      img = ::Magick::Image::read(@file.file).first 
      @geometry = [ img.columns, img.rows ] 
    end 
  end    
  



  def crop
    if model.crop_x.present?
      cols, rows = get_geometry
      manipulate! do |img|
        r_width, r_height = model.crop_r_width, model.crop_r_height
        width_ratio = (cols / r_width.to_i).to_f
        height_ratio = (rows / r_height.to_i).to_f  
        x = model.crop_x.to_i
        y = model.crop_y.to_i 
        w = model.crop_w.to_i
        h = model.crop_h.to_i
        #raise [x,y,w,h].inspect
        cropped_img = img.crop(x,y,w,h)
        # new_img= cropped_img.resize_to_fill(200,200)
        # destroy_image(cropped_img)
        destroy_image(img)
        cropped_img
      end
    end
  end

end