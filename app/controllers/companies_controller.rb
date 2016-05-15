class CompaniesController < ApplicationController

	def index
  	@operations = Operation.all
  	@companies = Company.all
  	@accepted = Operation.accepted
    @average_amount = average_amount
  	@highest_operation = highest
    @operation = Operation.first
  end

  def export_data #eport data to csv file
    @company_export = Company.find(params[:id]) 
    @operations_export = Operation.where(company_id: params[:id])
      
    respond_to do |format|
      format.html
      format.csv { send_data @operations_export.to_csv}
    end  
  end

  def create
  end

  def filter 
    @filtered_data = []
    @kind = params[:filter_var]
    value = params[:value].downcase
    case @kind 
    when 'status'   
      @filtered_data=Operation.status(value)
    when 'kind'
      @filtered_data=Category.kind(value)
    when 'invoice_num'
      @filtered_data=Operation.invoice_num(value)
    when 'reporter'
      @filtered_data=Operation.reporter(value)
    end
  end

	def average_amount
  	average =[]
  	@companies.each do |company|
      @data = company.operations.average(:amount)
      @data = @data.ceil(2) if @data != nil
      average << @data
    end
		return average
 	end

 	def highest 
 		highest_arr = []
 		@companies.each do |company|
	    @d=company.operations.highest_from_current_month.maximum(:amount)
		  highest_arr << @d
		end
 		return highest_arr
 	end

end