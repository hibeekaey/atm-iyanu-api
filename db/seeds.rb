# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  customer_one = User.new
  customer_one.first_name= 'Iyanu'
  customer_one.surname= 'Adelekan'
  customer_one.middle_name= 'Oluwaseun'
  customer_one.email= 'iyanuadelekan@gmail.com'
  customer_one.phone_number= '08184209188'

  if customer_one.save
    Account.attempt_creation(
        customer_one.id,
        "#{customer_one.first_name} #{customer_one.surname}",
        nil,
        100000)
  end
end

ActiveRecord::Base.transaction do
  customer_two = User.new
  customer_two.first_name= 'Emmanuel'
  customer_two.surname= 'Adegbite'
  customer_two.middle_name= 'Pelumi'
  customer_two.email= 'curious@gmail.com'
  customer_two.phone_number= '08184209199'

  if customer_two.save
    Account.attempt_creation(
        customer_two.id,
        "#{customer_two.first_name} #{customer_two.surname}",
        nil,
        1200000)
  end
end