# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.delete_all
User.delete_all
Product.create(name: 'Agua Cristal', description: 'Agua pura en envase de 650ml', stock: 3, price: 0.50)
Product.create(name: 'Galleta Tosh', description: 'galleta con sabor a yogurt y arandanos', stock: 10, price: 0.75)
Product.create(name: 'Planters', description: 'honey roasted peanuts', stock: 50, price: 1.00)
User.create(username: "maxisun", password: "lolis123", is_admin: true)
User.create(username: "maxisun2", password: "lolis123", is_admin: false)

