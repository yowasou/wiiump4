class Video < ActiveRecord::Base
  belongs_to :user
  def encryptor
    secret = ENV["ENC_KEY"]
    ::ActiveSupport::MessageEncryptor.new(secret)
  end

  def video_data=(val)
    encryptor = self.encryptor
    write_attribute("video_data",encryptor.encrypt_and_sign(val))
  end

  def video_data
    encryptor = self.encryptor
    encryptor.decrypt_and_verify(read_attribute("video_data"))
  end
end
