class MemberMailer < ApplicationMailer
  default from: 'remco.huijdts@fanfaresintservatius.nl'


  def notify_message(message)
    @message = message
    @messageable = message.messageable
    @members = @messageable.members
    @sender = @message.member
    mail(to: 'no_reply@onzemuziek.nl', bcc: @members.pluck(:email), subject: "Bericht ontvangen in #{@sender.band.name} ledensite" )
  end


end