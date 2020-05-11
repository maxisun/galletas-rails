#json.products @products, :id, :name, :description, :stock, :price
json.links do
  json.self api_v1_products_url
end

json.products @products do |product|
  json.(product, :id, :name, :description, :stock, :price)
  json.likes product.likes.count
end
