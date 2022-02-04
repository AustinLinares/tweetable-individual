require "faker"
require 'open-uri'

User.destroy_all
Tweet.destroy_all
Comment.destroy_all

p "Creating admin(without role)"
admin = User.new(
  username: "@the_three_silents_guy",
  name: "Patrick Rothfuss",
  email: "admin@mail.com",
  password: "letmein",
)
admin.avatar.attach(io: URI.open(Faker::Avatar.image(slug: "my-own-slug", size: "50x50")), filename: "sanderson.jpg")
puts "Admin not created. Errors: #{admin.errors.full_messages}" unless admin.save


puts "Seeding users"
4.times do |user|
  character = Faker::Books::TheKingkillerChronicle.character
  user = User.new
  user.username = "@#{character}"
  user.name = character
  user.email = "#{character}@mail.com"
  user.password = "letmein"
  user.avatar.attach(io: URI.open(Faker::Avatar.image(slug: "my-own-slug", size: "50x50")), filename: "#{character}-image.jpg")
  puts "User not created. Errors: #{user.errors.full_messages}" unless user.save
end

puts "Seeding tweets"
users = User.all
users.each do |user|
  rand(1..2).times do
    new_tweet = Tweet.new
    new_tweet.user = user
    new_tweet.body = Faker::Lorem.sentence(word_count: rand(3..6))
    puts "Tweet not created. Errors: #{new_tweet.errors.full_messages}" unless new_tweet.save
  end
end

# puts "Seeding Comments"

# tweets = Tweet.all
# tweets.each do |tweet|
#   rand(3..4).times
#     new_comment = Comment.new
#     new_comment.tweet = tweet
#     new_comment.user = User.all.sample
#     new_comment.body = Faker::Lorem.sentence(word_count: rand(3..6))
#     puts "Comment not created. Errors: #{new_comment.errors.full_messages}" unless new_comment.save
#   end
# end