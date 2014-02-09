class ChatController < ApplicationController
  
  def index
    @logged_in_user = session[:user_id]
    session[:last_loaded_message_id] = 1
  end
  
  def load_messages
    @messages = Message.find(
      :all, 
      :conditions => 'messages.id > ' + session[:last_loaded_message_id].to_s + ' and deleted = 0', 
      :order => 'created_at DESC', 
      :limit => 5, 
      :joins => :user
    )
    
    @messages.reverse!
    
    if @messages.present? 
      session[:last_loaded_message_id] = @messages[ @messages.length - 1].id.to_i
    end
    
    @logged_in_user = session[:user_id].to_i
    
    render :layout => false
  end
  
  def new_message
    render :text => ( Message.last.id.to_i > session[:last_loaded_message_id] ) ? 1 : 0;
  end
  
  def clear_messages
    render :nothing => true
   
    @messages = Message.find(:all, :conditions => { :deleted => 0 })
    
    @messages.each do |message| 
      message.deleted = 1
      message.save
    end
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
