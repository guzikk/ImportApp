class AddOperationRefToCategory < ActiveRecord::Migration
  def change
    add_reference :categories, :operation, index: true, foreign_key: true
  end
end
