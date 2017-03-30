class AddActionAndPlayeridToCity < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :playerId, :string
    add_column :cities, :action, :string
  end
end
