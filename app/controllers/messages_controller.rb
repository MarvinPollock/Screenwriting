class MessagesController < ApplicationController
  respond_to :html, :json, :js
  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
  def index
    @messages = Message.where(:receiver => current_user.first_name)
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
    respond_with do |format|
       if object == "Invitation"
         aMsgs = Message.all
         gefunden = false
         aMsgs.each { |m|
           gefunden ||= m.sender == sender && m.receiver == receiver && m.object == "Invitation"
         }
         
         if gefunden
            format.json{render :json => {:success => "OK"}}
         else
            @msg.content = "/message/antwort?sender=#{sender}&groupId=#{groupId}"
            if @msg.save
                format.json{render :json => {:success => "OK"}}
            else
              format.json{render :json => {:error => @msg.errors.full_messages}}
            end
         end
         
       else
         format.json{render :json => {:error => "Object stimmt nicht"}}
       end
    end
    
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
