class User < ActiveRecord::Base
  def encryptor
    secret = ENV["ENC_KEY"]
    ::ActiveSupport::MessageEncryptor.new(secret)
  end

  def icon=(val)
    encryptor = self.encryptor
    write_attribute("icon",encryptor.encrypt_and_sign(val))
  end

  def icon
    encryptor = self.encryptor
    encryptor.decrypt_and_verify(read_attribute("icon"))
  end
end
