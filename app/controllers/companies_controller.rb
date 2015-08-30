class CompaniesController < ApplicationController

  def index
    @companies = Company.all
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.create(company_params)

    if @company.save
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @company = Company.find(params[:id])

    if @company.update_attributes(params[:company])
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    redirect_to companies_url
  end

  def import_data
    @company = Company.find(params[:id])
    if @company.import(params[:file])
      redirect_to @company, notice: 'Data import successful.'
    else
      redirect_to @company, notice: 'Data import not succcessful.'
    end
  end

  private
  def company_params
    params.require(:company).permit(:company_name)
  end

end
