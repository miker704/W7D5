class ApplicationController < ActionController::Base
    protect_from_forgery with: :expection

    #chrrlll
    helper_method :current_user, :signed_in?, :require_logged_in

    def current_user
        @current_user ||= User.find_by(session_token: sessions[:session_token])
    end

    def require_logged_in
        redirect_to new_session_url if !logged_in?
    end

    def require_logged_out
        redirect_to users_url if logged_in?
    end

    def log_in(user)
        session[:session_token] = user.reset_session_token!
    end

    def log_out
        @current_user.reset_session_token! if logged_in?
        session[:session_token] = nil
        @current_user = nil
    end

    def logged_in?
        !!current_user
    end
end
