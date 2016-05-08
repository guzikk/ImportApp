class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.references :category, index: true, foreign_key: true
      t.references :operation, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
