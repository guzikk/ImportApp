class UploadDataController < ApplicationController

require 'csv'


def index
	#@data = file
	#@data = params[:file]
	#csv = CSV.new(body, :headers => true, :header_converters => :symbol, :converters => :all)
	#csv.to_a.map {|row| row.to_hash }


	#@data = []
	#CSV.foreach(file.path, headers: true) do |row|
		#@data << row.to_hash
end

def create
#file = params[:file]
file = Rails.root.join(params[:file].original_filename)
@data3 = Company.all
#CSV.foreach(file, headers: true, row_sep:"\n") {|file| @data << file }
@data2= SmarterCSV.process(file, headers: true, chunk_size:1000, col_sep: ",", remove_empty_values: false, :key_mapping => {:company => :company_id}) 


@data2.each do |data2|

data2.each do |h|

	@data3.each do |t|
		if h[:company_id] == t.name
			h[:company_id] = t.id.to_i
		end
	end
		if  h[:company_id].class == String
			h[:company_id] = 0
		end
end
end


@data2.each do |t|
	t.each do |k|
		@data = Operation.new
		#@data3.each do |cos|
		#if cos.name == k[:company_id] 
		#	k[:company_id] = cos.id
		#	@data4 << cos.id
		#	@data5 << k[:company_id] 
		#								end
		#	end
		k.each do |x,y|
			@data[x] = y
					end
		@data.save
	end
end


#File.open(Rails.root.join(file.original_filename), "r") {|file| @data << file.read }
#@data << file.read
#file.close

render 'index'
#CSV.foreach(file.path, headers: true) do |row|
#		@data << row.to_hash
#	end
#@data = file
#redirect_to action: 'index'
end


private

end
