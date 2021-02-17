module ApplicationHelper

  def show_user_picture_for(user, options = {size: 80})
    email_address = user.email.downcase

    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    picture_URL = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"

    image_tag(picture_URL, alt: user.username, class: "rounded shadow mt-4")
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = 'You must log in to perform that action.'
      redirect_to login_path
    end
  end

  def user_is_admin?
    !!current_user.admin?
  end


end