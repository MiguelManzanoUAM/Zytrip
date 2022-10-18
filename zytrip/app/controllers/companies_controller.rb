class CompaniesController < ApplicationController

  def new
    @company = Company.new
  end

  def create
    @preference = Preference.last
    @company = Company.new(company_params.merge(preference_id: @preference.id))
    @company.save
    redirect_to new_service_path
  end
  
  def company_params
    params.require(:company).permit(:family, :romantic, :friends, :alone, :people)
  end
end