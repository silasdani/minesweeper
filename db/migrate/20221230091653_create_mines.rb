class CreateMines < ActiveRecord::Migration[6.1]
  def change
    create_table :mines do |t|
      t.string :map
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
