class AddWrongguessToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :wrongguess, :string
  end
end
