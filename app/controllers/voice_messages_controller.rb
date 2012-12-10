class VoiceMessagesController < ApplicationController
  def new
    @voice_message = VoiceMessage.new
    @submit_label = "Create"
  end
  def create
    @voice_message = VoiceMessage.new(params[:voice_message])
    @client = Twilio::REST::Client.new @voice_message.account_sid, @voice_message.auth_token
    @my_message = @voice_message.body
    @client.account.calls.create(
       :from => @voice_message.from_number,
       :to => @voice_message.to_number,
       :url => "http://66.128.53.208:3400/voice_messages/voice_send"
    )
    if @voice_message.save
      flash[:notice] = "Voice Message has been created."
      redirect_to :action => "index", :controller => "home"
    else
      flash[:notice] = "Voice Message has not been created."
      render :action => "new"
    end
  end
end
