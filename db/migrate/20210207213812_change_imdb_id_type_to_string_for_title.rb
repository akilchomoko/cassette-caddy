class ChangeImdbIdTypeToStringForTitle < ActiveRecord::Migration[6.0]
  def change
    change_column :titles, :imdb_id, :string
  end
end
