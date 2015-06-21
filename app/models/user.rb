class User < ActiveRecord::Base
  def icon_path
    "data/" + filename
  end
end
