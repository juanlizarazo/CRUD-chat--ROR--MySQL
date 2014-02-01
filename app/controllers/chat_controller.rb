class ChatController < ApplicationController
  
  def index
    @logged_in_user = session[:user_id]
  end
  
  def load_messages
    @messages = Message.find(:all, :order=>'created_at DESC', :limit => 5, :joins => :user)
    @messages.reverse!
    
    @logged_in_user = session[:user_id].to_i
    
    render :layout => false
  end
  
  def send_message
    render :nothing => true
    
    # Insert message in DB
    @sent_to = (session[:user_id] == 1) ? 2 : 1
    @message = Message.new(message: params[:message], sent_by: session[:user_id], sent_to: @sent_to)
    
    # Response to ajax call
    true if @message.save
  end
  
end