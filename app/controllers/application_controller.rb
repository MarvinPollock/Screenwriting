class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticationHelper
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/users', :alert => exception.message
  end
  
end
