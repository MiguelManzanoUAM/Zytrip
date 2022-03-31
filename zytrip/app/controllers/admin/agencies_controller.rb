class Admin::AgenciesController < ApplicationController
  def index
    unless current_user and current_user.admin?
      redirect_to root_path, error: "You don't belong there"
    end
    
    @agencies = Agency.search(params[:search])
  end

  def show

  end

  def new
    @agency = Agency.new
  end

  def create
    @agency = Agency.new(agency_params)
    @agency.save
  end

  def destroy
    @agency = Agency.find_by(id: params[:id])
    redirect_to admin_agencies_path unless @agency
    @agency.destroy
    redirect_to admin_agencies_path
  end

  def edit
    @agency = Agency.find_by(id: params[:id])
    redirect_to admin_agencies_path unless @agency
  end

  def update
    @agency = Agency.find_by(id: params[:id])
    @agency.update(agency_params)
    redirect_to admin_agencies_path
  end

  private

    def agency_params
      params.require(:trip).permit(:name)
    end
end
