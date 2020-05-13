json.links do
  json.self purchases_logs_api_v1_products_url
end
  
json.purchases_logs @purchases_logs do |purchases_log|
  json.id purchases_log.id
  json.user purchases_log.user, :id, :username, :is_admin
  json.product purchases_log.product, :id, :name, :description, :stock, :price
  json.quantity purchases_log.quantity
  json.timestamp purchases_log.created_at
end