class AddDeviceuuidToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :device_uuid, :string, null: false, default: '', after: :encrypted_password
    #talbe name, column name, column_type, option:null, option default, Order of column
  end
end