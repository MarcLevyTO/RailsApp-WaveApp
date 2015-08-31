class CompaniesController < ApplicationController

  def index
    @companies = Company.all.order('id desc').paginate(:per_page => 10, :page => params[:page])
  end

  def show
    @company = Company.find(params[:id])

    @company_datum = @company.company_datum.order(sort_column + " " + sort_direction).paginate(:per_page => 20, :page => params[:page])
    @grouped_datum = @company.company_datum.all.group_by { |t| t.date.beginning_of_month }
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
      render action: "new", notice: 'Company name already exists'
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

     def sort_column
      CompanyDatum.column_names.include?(params[:sort]) ? params[:sort] : "date"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end
