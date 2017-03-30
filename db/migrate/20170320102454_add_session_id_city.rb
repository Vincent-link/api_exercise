class AddSessionIdCity < ActiveRecord::Migration[5.0]
  def change
    add_column :cities, :sessionId, :string
  end
end
