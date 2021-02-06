class CreateTitles < ActiveRecord::Migration[6.0]
  def change
    create_table :titles do |t|
      t.string :title
      t.text :description
      t.references :genre, null: false, foreign_key: true
      t.integer :release_year
      t.integer :rate_per_day

      t.timestamps
    end
  end
end
