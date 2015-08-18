class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :request
      t.string :response

      t.timestamps null: false
    end
  end
end
