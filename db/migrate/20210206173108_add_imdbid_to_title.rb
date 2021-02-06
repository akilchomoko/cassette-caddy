class AddImdbidToTitle < ActiveRecord::Migration[6.0]
  def change
    add_column :titles, :imdb_id, :integer
  end
end
