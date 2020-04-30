if @product.save! 
  json.Location url_for(@product)