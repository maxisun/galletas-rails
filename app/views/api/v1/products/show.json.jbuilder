json.links do
  json.self api_v1_product_url(@product)
end

json.data do
  json.type "products"
  json.id @product.id
  json.attributes do
    json.name @product.name
    json.description @product.description
    json.stock @product.stock
    json.price @product.price
  end
end
