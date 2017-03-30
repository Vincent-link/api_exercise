class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :sessionId
      t.string :word
      t.string :totalWordCount
      t.timestamps
    end
  end
end
