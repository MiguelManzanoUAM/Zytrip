class TripsResearchController < ApplicationController
  def survey
  end

  def results

    if params[:iberic]
      @message = "Recibe bien el parametro"
      @trips = Trip.all
      @result_trips = []

      @trips.each do |t|
        if t.preference.destination_spain?
          @result_trips << t
        end
      end

    else
      @message = "Parametro no recibido"
      @result_trips = Trip.all
    end
  end
end
