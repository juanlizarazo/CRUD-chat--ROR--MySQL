class UserController < ApplicationController
  
  def index
    @users = User.all
  end
  
  def login
    session[:user_id] = params[:id]
    redirect_to(:controller => 'chat', :action => 'index')
  end
  
end
