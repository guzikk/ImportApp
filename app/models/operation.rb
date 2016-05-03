class Operation < ActiveRecord::Base
  belongs_to :company
  has_and_belongs_to_many :categories

  #before_validation :operation, on: [ :update ]
  validates_presence_of :invoice_num, :invoice_date, :amount, :operation_date, :kind, :status
  validates_numericality_of :amount, greater_than: 0
  validates_uniqueness_of :invoice_num

  

  #def operation
    
   # :company_id = 1
    #n = Company.all 
  	#n.each do |t|
  	#byebug
    #if :company_id == t.name 

      #:company_id = t.id
  		#self.update_attribute(:company_id, '1')
      
      #self.company_id = t.id
    #else
     # self.update_attribute(:company_id, 1)
      #:company_id = 1
	  #end
    #end
  #end
end
