class Admin::AdditionalInformationsController < ApplicationController

  def index
    unless current_user and current_user.admin?
      redirect_to root_path, error: "You don't belong there"
    end
    
    @additional_informations = AdditionalInformation.all

    respond_to do |format|
      format.html
      format.csv { send_data @additional_informations.to_csv(['id', 'user_id', 'slogan', 'phone_number', 'instagram_nickname', 'image_url', 'description']) }
    end
  end

  def new
    @additional_information = AdditionalInformation.new
  end

  def create
    @additional_information = AdditionalInformation.new(additional_information_params)
    @additional_information.save
    redirect_to admin_additional_informations_path
  end

  def destroy
    @additional_information = AdditionalInformation.find_by(id: params[:id])
    redirect_to admin_additional_informations_path unless @additional_information
    @additional_information.destroy
    redirect_to admin_additional_informations_path
  end

  def edit
    @additional_information = AdditionalInformation.find_by(id: params[:id])
    redirect_to admin_additional_informations_path unless @additional_information
  end

  def update
    @additional_information = AdditionalInformation.find_by(id: params[:id])
    @additional_information.update(additional_information_params)
    redirect_to admin_additional_informations_path
  end

  def import
    AdditionalInformation.import()
    redirect_to admin_additional_informations_path
  end

  private
  
  def additional_information_params
    params.require(:additional_information).permit(:user_id, :slogan, :phone_number, :instagram_nickname, :image_url, :description)
  end
end