class Admin::CompaniesController < ApplicationController

  def index
    unless current_user and current_user.admin?
      redirect_to root_path, error: "You don't belong there"
    end
    
    @companies = Company.all

    respond_to do |format|
      format.html
      format.csv { send_data @companies.to_csv(['id', 'preference_id', 'family', 'romantic', 'friends', 'alone', 'people']) }
    end
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    @company.save
    redirect_to admin_companies_path
  end

  def destroy
    @company = Company.find_by(id: params[:id])
    redirect_to admin_companies_path unless @company
    @company.destroy
    redirect_to admin_companies_path
  end

  def edit
    @company = Company.find_by(id: params[:id])
    redirect_to admin_companies_path unless @company
  end

  def update
    @company = Company.find_by(id: params[:id])
    @company.update(company_params)
    redirect_to admin_companies_path
  end

  def import
    Company.import()
    redirect_to admin_companies_path
  end

  def company_params
    params.require(:company).permit(:preference_id, :family, :romantic, :friends, :alone, :people)
  end
end