class AddLikesCountToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :likes_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE products
           SET likes_count = (SELECT count(1)
                                   FROM likes
                                  WHERE likes.product_id = products.id)
    SQL
  end
end
