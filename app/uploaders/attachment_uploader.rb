# encoding: utf-8
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/mime_types'
class AttachmentUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{Rails.root}/public/uploads/attachments"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
     "/images/default.jpg"
  end

  process :convert => 'png'
  version :thumb do
    process :resize_to_fit => [300, 10000]
  end
  process :set_content_type

  def extension_white_list
    %w(jpg jpeg gif png pdf)
  end

  def filename
    #"#{Time.now.to_i}.png"
    super.chomp(File.extname(super)) + '.png' if original_filename.present?
  end

end
