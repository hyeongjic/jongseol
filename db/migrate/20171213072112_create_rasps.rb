class CreateRasps < ActiveRecord::Migration[5.1]
  def change
    create_table :rasps do |t|
      t.string :rasp_id, null: false, default: ""
      t.string :rasp_ip, null: false, default: ""
      t.timestamps
    end
  end
end
