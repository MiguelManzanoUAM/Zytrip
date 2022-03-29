class AgenciesController < ApplicationController

  # GET /agencies or /agencies.json
  def index
    @agencies = Agency.all
  end

  # GET /agencies/1 or /agencies/1.json
  def show
    
  end
end
