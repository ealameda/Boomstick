class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :normalize_page_number

  protected
  def current_user
    @current_user || login_from_session
  end

  def login_from_session
    session[:consumer] if session[:consumer]
  end

  def current_user=(user)
    session[:consumer] = user
    @current_user = user
  end

  def normalize_page_number(page)
    page = 1 if page.to_i == 0
    page.to_i.abs
  end
end
