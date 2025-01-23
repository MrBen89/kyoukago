# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server
<<<<<<< HEAD

cloudinary:
  service: Cloudinary
  cloud_name: <%= ENV['CLOUDINARY_CLOUD_NAME'] %=>
  api_key: <%= ENV['CLOUDINARY_API_KEY'] %=>
  api_secret: <%= ENV['CLOUDINARY_API_SECRET'] %=>
=======
>>>>>>> 03c8adc7379ed5aaae101d3f1c973932425e04c6
