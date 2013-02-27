class MessagesController < ApplicationController
  respond_to :html, :json, :js
  def index
    @messages = Message.where(:receiver => current_user.first_name)
  end
  
  def new
    
  end
  
  def create
    sender = params[:sender]
    receiver = params[:receiver]
    object = params[:object]
    groupId = params[:groupId]
    @msg = Message.new
    @msg.sender = sender
    @msg.receiver = receiver
    @msg.object = object
    #respond_with do |format|
       if object == "Invitation"
         @msg.content = "/message/antwort?sender=#{sender}&groupId=#{groupId}"
         if @msg.save
            render :text => "OK"
         else
           render :text => @msg.errors.full_messages
         end
       else
         render :text => "Object stimmt nicht"
       end
    #end
    
  end
  
  def antwort
    user = current_user
    senderName = params[:sender]
    groupId = params[:groupId]
      
    if sender = User.find(:first, :conditions => ["first_name=?", senderName])
      
       group = sender.groups.find(:first, :conditions => ["id=?", groupId])
       
       if group && !group.users.exists?(user)
          group.users << user
          render :text => "Sie sind jetzt in der Gruppe drin."
       else
         render :text => group.users
       end
       
    else
       render :text => "Diese Gruppe ist schon voll. Suchen Sie sich eine andere Gruppe."
    end 
    
  end
  
  def destroy
    
  end
  
  def update
    
  end
  
end
