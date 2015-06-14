class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_filter :basic
  private
  #def basic
  #  upass = ENV["USER_PASS"]
  #  u = upass.split(":")[0]
  #  p = upass.split(":")[1]

  #  authenticate_or_request_with_http_basic do |user, pass|
  #    user == u && pass == p
  #  end
  #end
end
