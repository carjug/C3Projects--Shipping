class CreateCarriers < ActiveRecord::Migration
  def change
    create_table :carriers do |t|
      t.string :name
      t.string :service_name

      t.timestamps null: false
    end
  end
end
