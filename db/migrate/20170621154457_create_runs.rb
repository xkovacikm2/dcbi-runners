class CreateRuns < ActiveRecord::Migration[5.0]
  def change
    create_table :runs do |t|
      t.integer :duration, null: false
      t.float :distance, null: false
      t.date :date, null: false
      t.references :user, foreign_key: true, index: true, null: false

      t.timestamps
    end
  end
end
