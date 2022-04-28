class CreateMeasurements < ActiveRecord::Migration[7.0]
  def change
    create_table :measurements do |t|
      t.float :current_power
      t.float :yield_today
      t.float :total_yield
      t.string :alert

      t.timestamps
    end
  end
end
