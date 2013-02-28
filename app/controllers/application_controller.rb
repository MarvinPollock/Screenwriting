class ApplicationController < ActionController::Base
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'text' }
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'js' }
  protect_from_forgery
  include AuthenticationHelper
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to '/users', :alert => exception.message
  end
  
end
