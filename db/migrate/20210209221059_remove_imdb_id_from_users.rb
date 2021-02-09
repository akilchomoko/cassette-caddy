class RemoveImdbIdFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :imdb_id, :integer
  end
end
