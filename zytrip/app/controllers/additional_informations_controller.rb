class AdditionalInformationsController < ApplicationController
  def new
    @additional_information = AdditionalInformation.new
  end

  def create
    @additional_information = AdditionalInformation.new(user_id: current_user.id, slogan: params[:slogan], phone_number: params[:phone_number], instagram_nickname: params[:instagram_nickname], image_url: params[:image_url], description: params[:description])
    @additional_information.save
    redirect_to users_profile_path(@additional_information.user_id)
  end

  private

  def additional_information_params
    params.require(:additional_information).permit(:user_id, :slogan, :phone_number, :instagram_nickname, :image_url, :description)
  end

end
