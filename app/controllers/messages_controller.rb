class MessagesController < ApplicationController
  
  def index
    
  end
  
  def new
    
  end
  
  def create
    sender = params[:sender]
    receiver = params[:receiver]
    object = params[:object]
    @message = Message.new
    @message.sender = sender
    @message.receiver = receiver
    @message.object = object
    if object == "Invitation"
      @message.content = "/message/response?sender=#{sender}&receiver=#{receiver}"
      true
    elsif
      false
    end
    
  end
  
  def response
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
        receiver.groups << sender
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
