class Operation < ActiveRecord::Base
  require 'csv'

  belongs_to :company
  has_many :links
  has_many :categories, through: :links



  validates_presence_of :invoice_num, :invoice_date, :amount, :operation_date, :kind, :status
  validates_numericality_of :amount, greater_than: 0
  validates_uniqueness_of :invoice_num
  
  scope :accepted, ->{where status: 'accepted'}
  scope :highest_from_current_month, lambda {where("operation_date > ? AND operation_date < ?", Time.now.beginning_of_month, Time.now.end_of_month)}
  scope :status, lambda { |value| where(:status  => value) }
  scope :kind, lambda { |value| where(:kind  => value) }
  scope :invoice_num, lambda { |value| where(:invoice_num  => value) }
  scope :reporter, lambda { |value| where(:reporter  => value) }

  
  def self.to_csv(options={})
    values =[]
    attributes = %w[company invoice_num invoice_date operation_date amount reporter notes status kind]
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |emp|
        if emp.company
          values = emp.company.attributes.slice("name").values
        end
        values += emp.attributes.slice("invoice_num", "invoice_date" "operation_date" "amount", "reporter", "notes", "status", "kind").values
        csv.add_row values
      end
    end
  end

end
