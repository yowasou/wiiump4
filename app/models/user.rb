class User < ActiveRecord::Base
  has_one :video, dependent: :destroy
end
