class CreatePriceLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :price_logs do |t|
      t.references :product, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.decimal :previousPrice
      t.decimal :updatedPrice

      t.datetime :created_at
    end
  end
end
