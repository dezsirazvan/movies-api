# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.find_by(email: "user@gmail.com")

User.create!(email: "user@gmail.com", password: '123456', full_name: "User Movies Api") unless user.present?

10.times do |index|
  Movie.create!(title: "Movie #{index}", plot: "Movie description#{index}")
end

10.times do |index|
  season = Season.create!(title: "Season #{index}", plot: "Season description#{index}")
  
  10.times do |index|
    Episode.create!(title: "Episode #{index}", plot: "Episode description#{index}", season_id: season.id)
  end
end