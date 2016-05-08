class UploadDataController < ApplicationController

	def index
	end

	def create
		imported_row_true = 0
		imported_row_false = 0
		rows = 0
		@data3 = Company.all
		file = Rails.root.join(params[:file].original_filename)
		@data= SmarterCSV.process(file, headers: true, chunk_size:1000, col_sep: ",", remove_empty_values: false, verbose: true, :key_mapping => {:company => :company_id})  
	
		@data.each do |data2|
			data2.each do |h|
				@data3.each do |t|
					if h[:company_id] == t.name
			   			h[:company_id] = t.id.to_i
					end
				end		
			
				if h[:company_id].class == String
					h[:company_id] = 0
				end

				if h[:kind] == nil
					h[:kind] = "missing"
				end

				h[:kind] = h[:kind].downcase
				h[:status] = h[:status].downcase	

			end
		end

		@data.each do |t|
			t.each do |k|
				rows +=1
				data = Operation.new
				k.each do |k,v|
					data[k] = v
				end
			
				if data.save 
					imported_row_true+=1
				else
					imported_row_false+=1
				end
			end
		end

	
		@operation = Operation.all
		@operation.each do |kind2|
			@kind = kind2.kind.split(";")
			@kind.each_with_index do |kind,index| 
				@category = Category.create(:name=>kind)
				@link = Link.create(:operation_id => kind2["id"], :category_id=>@category.id)
			end
		end	

		flash[:notice] = "All rows: #{rows}; imported successfully: #{imported_row_true}; not imported: #{imported_row_false}"
		redirect_to companies_path
	end

end



