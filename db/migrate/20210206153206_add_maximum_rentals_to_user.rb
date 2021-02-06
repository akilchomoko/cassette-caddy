class AddMaximumRentalsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :maximum_rentals, :integer
  end
end
