class CalendarsController < ApplicationController
  load_and_authorize_resource

  def show
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    respond_to do |format|
      format.html { render :edit }
      format.js
    end
  end

  def create
    @calendar.add_and_remove_days(params[:calendar][:calendar_workday_ids])
    respond_to do |format|
      if @calendar.update_attributes(calendar_params)
        format.html { redirect_to [current_company, @calendar] }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @calendar.add_and_remove_days(params[:calendar][:workday_ids])

    respond_to do |format|
      if @calendar.update_attributes(calendar_params)
        format.html { redirect_to [current_company, @calendar] }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to :root }
      format.js
    end
  end

  private

  def calendar_params
    params.require(:calendar).permit(:name, :business_hours_start, :business_hours_end, :editable, :calendar_workday_ids)
  end
end
