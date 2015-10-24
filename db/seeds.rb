Product.destroy_all
User.destroy_all
Category.destroy_all

users = []

users << User.create(
  name: 'Juan Cristobal',
  lastname: 'Pazos',
  username: 'juancri',
  email: 'admin@ecommerce.com',
  password: 'password',
  role: 0
)
users << User.create(
  name: 'Maida',
  lastname: 'Claro',
  username: 'mai_clear',
  email: 'client@ecommerce.com',
  password: 'password',
  role: 1
)


categories = []

categories << Category.create(name: 'Man')
categories << Category.create(name: 'Woman')
categories << Category.create(name: 'Sport')
categories << Category.create(name: 'Computers')
categories << Category.create(name: 'Children')
categories << Category.create(name: 'Toys')
categories << Category.create(name: 'Books')
categories << Category.create(name: 'Video Games')
categories << Category.create(name: 'Music')
categories << Category.create(name: 'Movies')
categories << Category.create(name: 'Others')


products = []

80.times do |p|
  products << Product.create(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(10, true, 10),
    price: Faker::Commerce.price,
    stock: Faker::Number.between(1, 20)
  )

end
