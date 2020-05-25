#json.products @products, :id, :name, :description, :stock, :price
json.linksbenji do
  json.self api_v1_products_url
end

json.products @products do |product|
  json.(product, :id, :name, :description, :stock, :price)
  json.likes product.likes_count
end
