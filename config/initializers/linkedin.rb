LinkedIn.configure do |config|
  if Rails.env.production?
    config.token = "uyy178z1olhz"
    config.secret = "vqyZufPr8jWOchK8"
  else
    config.token = "mqguba5cny5d"
    config.secret = "iUYJbx61BLB0dZDP"
  end
end