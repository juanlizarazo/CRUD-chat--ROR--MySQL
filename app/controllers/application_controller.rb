class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :render_profile_pic
  helper_method :check_new_messages
  
  
  def render_profile_pic (user)
    ActionController::Base.helpers.image_tag("profile_pics/" + user.profile_pic)
  end
  
  def check_new_messages
    @newest_message = Message.last.id.to_i
    @last_loaded_message = session[:message_id]
    
    true if (@newest_message >= @last_loaded_message)     
  end
  
end
