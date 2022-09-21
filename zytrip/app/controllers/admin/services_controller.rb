class Admin::ServicesController < ApplicationController

  def index
    unless current_user and current_user.admin?
      redirect_to root_path, error: "You don't belong there"
    end
    
    @services = Service.all

    respond_to do |format|
      format.html
      format.csv { send_data @services.to_csv(['id', 'preference_id', 'lodging', 'gastronomy', 'activities']) }
    end
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.save
    redirect_to admin_services_path
  end

  def destroy
    @service = Service.find_by(id: params[:id])
    redirect_to admin_services_path unless @service
    @service.destroy
    redirect_to admin_services_path
  end

  def edit
    @service = Service.find_by(id: params[:id])
    redirect_to admin_services_path unless @service
  end

  def update
    @service = Service.find_by(id: params[:id])
    @service.update(service_params)
    redirect_to admin_services_path
  end

  def import
    Service.import()
    redirect_to admin_services_path
  end

  def service_params
    params.require(:service).permit(:preference_id, :lodging, :gastronomy, :activities)
  end
end