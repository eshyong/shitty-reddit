class ApplicationController < ActionController::Base
  def require_login
    if logged_out?
      session[:redirect_to_path] = request.referer
      flash[:notice] = "Please login first before doing that."
      redirect_to(login_path)
    end
  end

  def logged_in?
    !session[:user_id].nil?
  end

  def logged_out?
    session[:user_id].nil?
  end

  def user_id
    session[:user_id]
  end
end
