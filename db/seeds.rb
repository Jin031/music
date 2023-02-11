# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Rails.env.development?
  Admin.create(email: 'xxx@xxx', password: '111111')

  (1..5).each do |i|
    Customer.create!(email: "xxx#{i}@xxx",
                     name: "test#{i}",
                     password: "111111")
  end
end

genres = %w(アニソン ボカロ ロック 邦楽 洋楽 J-POP )

genres.each{|name| Genre.create!(name: name)}
