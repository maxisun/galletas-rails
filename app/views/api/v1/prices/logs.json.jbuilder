json.links do
  json.self prices_logs_api_v1_products_url
end

json.price_logs @price_logs do |price_log|
  json.id price_log.id
  json.user price_log.user, :id, :username, :is_admin
  json.product price_log.product, :id, :name, :description, :stock, :price
  json.previousPrice price_log.previousPrice
  json.updatedPrice price_log.updatedPrice
  json.timestamp price_log.created_at
end