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
    respond_to do |format|
      if @calendar.save
        format.html { render :show }
        format.js
      else
        format.html { render :new }
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
    @calendar.update_attributes(calendar_params)
    respond_to do |format|
      if @calendar.save
        format.html { render :show }
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
    params.require(:calendar).permit(:name)
  end
end
