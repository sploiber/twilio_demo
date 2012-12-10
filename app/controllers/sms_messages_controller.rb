class SmsMessagesController < ApplicationController
  def new
    @sms_message = SmsMessage.new
    @submit_label = "Create"
  end
  def create
    @sms_message = SmsMessage.new(params[:sms_message])
    @client = Twilio::REST::Client.new @sms_message.account_sid, @sms_message.auth_token
    @client.account.sms.messages.create(
       :from => @sms_message.from_number,
       :to => @sms_message.to_number,
       :body => @sms_message.body
    )
    if @sms_message.save
      flash[:notice] = "Sms Message has been created."
      redirect_to :action => "index", :controller => "home"
    else
      flash[:notice] = "Sms Message has not been created."
      render :action => "new"
    end
  end
  def receive
    @message_body = params["Body"]
    @from_number = params["From"]
  end
  def voice_in
    @caller_id = params["From"]
  end
  def bad_receive
    p "Bad receive"
  end
end
