class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.references :user, foreign_key: true
      t.integer :visits
      t.string :geolocation
      t.boolean :enabled

      t.timestamps
    end
  end
end
