class ChangePhoneNumberToPhone < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :phone_number, :phone
  end
end
