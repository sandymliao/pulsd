class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def run_scraper
    system "rake db:master_reset"
    @events = Event.all
  end

  def create
    @event = Event.new(event_params)
    @event.save
  end

  def index
    #system "rake db:master_reset"
    
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end

  private
  def event_params
    params.require(:event).permit(:name, :start_date, :end_date, :time, :location)
  end
end
