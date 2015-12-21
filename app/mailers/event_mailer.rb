class EventMailer < ApplicationMailer
  def confirmation_email(event)
    @event = event
    mail(to: @event.client_email, subject: 'Confirm Your Appointment')
  end
end
