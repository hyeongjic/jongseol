class AddRasp < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :rasp_uuid, :string, null: false, default: '', after: :device_uuid
    #talbe name, column name, column_type, option:null, option default, Order of column

  end
end
