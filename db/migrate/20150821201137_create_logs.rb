class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :order_id
      t.string :app_name
      t.string :carrier_service

      t.timestamps null: false
    end
  end
end
