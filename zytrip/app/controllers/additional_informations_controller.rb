class AdditionalInformationsController < ApplicationController
  def new
    @additional_information = AdditionalInformation.new
  end

  def create
    @additional_information = AdditionalInformation.new(user_id: current_user.id, slogan: params[:slogan], phone_number: params[:phone_number], instagram_nickname: params[:instagram_nickname], image_url: params[:image_url], description: params[:description])
    
    if !@additional_information.save
      if params[:slogan].length > 30
        flash[:additional_information_error] = "slogan demasiado largo (máximo 30 caracteres)"

      elsif !(params[:phone_number] =~ /[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*@[a-zA-Z0-9_]+([.][a-zA-Z0-9_]+)*[.][a-zA-Z]{2,5}/)
        flash[:additional_information_error] = "Introduzca un nº teléfono válido con formato internacional"

      elsif params[:instagram_nickname].length > 16
        flash[:additional_information_error] = "introduce un usuario de instagram más corto (máximo 15 caracteres)"

      elsif params[:description].length > 250
        flash[:additional_information_error] = "descripción demasiado extensa (máximo 250 caracteres)"
      end
    end

    redirect_to users_profile_path(@additional_information.user_id)

  end

  private

  def additional_information_params
    params.require(:additional_information).permit(:user_id, :slogan, :phone_number, :instagram_nickname, :image_url, :description)
  end

end
