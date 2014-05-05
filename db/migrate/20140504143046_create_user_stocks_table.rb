class CreateUserStocksTable < ActiveRecord::Migration
  def change
    create_table :user_stocks do |t|
      t.belongs_to :user
      t.string :ticker_symbol
      t.integer :share_quantity
      t.timestamps
    end
  end
end
