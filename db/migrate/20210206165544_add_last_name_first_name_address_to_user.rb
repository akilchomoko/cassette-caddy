class AddLastNameFirstNameAddressToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :postcode, :string
    add_column :users, :phonenumber, :string
  end
end
