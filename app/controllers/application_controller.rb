class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticationHelper
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/users', :alert => exception.message
  end
  
  def set_current_pad(pad)
    @current_pad = pad
  end
  
  def current_pad
    return @current_pad
  end
  
  def set_current_project(proj)
    @current_project = proj
  end
  
  def current_project
    return @current_project
  end
  
end
