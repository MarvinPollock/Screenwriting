class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def sign_in
    if signed_in?
      redirect_to('/users/')
    end
  end

  def login
    redirect_to('/sessions/new')
  end

  def new
    response.headers['WWW-Authenticate'] = Rack::OpenID.build_header(
        :identifier => "https://openid.tzi.de/",
        :required => ["http://openid.tzi.de/spec/schema/mail",
                      "http://openid.tzi.de/spec/schema/givenName",
                      "http://openid.tzi.de/spec/schema/surName"],
        :return_to => session_url,
        :method => 'POST')
    head 401
  end

  def create
    if openid = request.env[Rack::OpenID::RESPONSE]
      case openid.status
        when :success
          ax = OpenID::AX::FetchResponse.from_success_response(openid)
          user = User.where(:identifier_url => openid.display_identifier).first
          user ||= User.create!(:identifier_url => openid.display_identifier,
                                :email => ax.get_single('http://openid.tzi.de/spec/schema/mail'),
                                :first_name => ax.get_single('http://openid.tzi.de/spec/schema/givenName'),
                                :last_name => ax.get_single('http://openid.tzi.de/spec/schema/surName'))
          session[:user_id] = user.id
          if user.first_name.blank?
            redirect_to(user_additional_info_path(user))
          else
            redirect_to('/users')
          end
        when :failure
          render :action => 'problem'
      end
    else
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to root_path
  end

end