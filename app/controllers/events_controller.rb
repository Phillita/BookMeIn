class EventsController < ApplicationController
  load_and_authorize_resource except: :confirm

  def confirm
    event = Event.find_by(client_email_confirm_token: params[:client_email_confirm_token])
    return redirect_to :root if event.client_email_confirm
    event.update_attribute(:client_email_confirm, true)
  end
end
