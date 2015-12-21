class EventsController < ApplicationController
  load_and_authorize_resource :calendar
  load_and_authorize_resource through: :calendar, except: :confirm

  def confirm
    event = Event.find_by(client_email_confirm_token: params[:client_email_confirm_token])
    return redirect_to :root if event.client_email_confirm
    event.update_attribute(:client_email_confirm, true)
  end

  def create
    respond_to do |format|
      if @event.save
        format.html
        format.js
      else
        Rails.logger.warn @event.errors.messages
        format.html { render :error }
        format.js { render :error }
      end
    end
  end

  def index
    @events = @calendar.events
    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  private

  def event_params
    params.require(:event).permit(:calendar_id,
                                  :start_dt,
                                  :end_dt,
                                  :client_name,
                                  :client_email,
                                  :client_phone,
                                  :client_comment)
  end
end
