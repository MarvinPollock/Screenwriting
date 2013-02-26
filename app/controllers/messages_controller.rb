class MessagesController < ApplicationController
  #respond_to :html, :json, :js
  def index
    @message = Message.where(:receiver => current_user.first_name)
  end
  
  def new
    
  end
  
  def create
    sender = params[:sender]
    receiver = params[:receiver]
    object = params[:object]
    @msg = Message.new
    @msg.sender = sender
    @msg.receiver = receiver
    @msg.object = object
    #respond_to do |format|
       if object == "Invitation"
         @msg.content = "/message/antwort?sender=#{sender}&receiver=#{receiver}"
         "Laeuft"
       else
         render :error => "Error"
       end
    #end
    
  end
  
  def antwort
    senderName = params[:sender]
    receiverName = params[:receiver]
    
    # ist der Sender in der Zwischenzeit einer Gruppe beigetreten?
    # wenn ja, dann wird diese Einladung nicht mehr beruecksichtigt.
    # Sonst wird noch geprueft, ob die Gruppe des Receivers schon die Maximale
    # Anzahl an Mitglieder hat. Ist das nicht der Fall, dann wird der Sender in der 
    # Gruppe aufgenommen und die Nachricht geloescht.
    sender = User.find(:first, :conditions => ["first_name=?", senderName])
      
    if sender.groups.empty?
      receiver = User.find(:first, :conditions => ["first_name=?", receiverName])
      if receiver.groups.size < 4
        receiver.groups.first << sender
      else
        "Diese Gruppe ist schon voll. Suchen Sie sich eine andere Gruppe."
      end
    else
      "Dieser Link ist nicht mehr gueltig, da Sie schon zu einer anderen Gruppe gehoeren. "
    end 
    
  end
  
  def destroy
    
  end
  
  def update
    
  end
  
end
