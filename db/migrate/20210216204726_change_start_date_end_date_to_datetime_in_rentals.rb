class ChangeStartDateEndDateToDatetimeInRentals < ActiveRecord::Migration[6.0]
  def up
    change_column :rentals, :start_date, :datetime
    change_column :rentals, :end_date, :datetime
  end

  def down
    change_column :rentals, :start_date, :date
    change_column :rentals, :end_date, :date
  end
end
