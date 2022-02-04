require "faker"
require 'open-uri'

User.destroy_all
Tweet.destroy_all
Comment.destroy_all

p "Start seeding users"
puts "Creating admin"
admin = User.new(
  username: "@admin",
  name: "Brandon Sanderson",
  email: "admin@mail.com",
  password: "supersecret",
  role: 1
)
admin.avatar.attach(io: File.open("app/assets/images/image_profile_default.png"), filename: "admin.png")
puts "Admin not created. Errors: #{admin.errors.full_messages}" unless admin.save


puts "Seeding users"
i = 1
4.times do |member|
  member = User.new
  member.username = "@visitor#{i}"
  member.name = Faker::Name.name
  member.email = "visitor#{i}@mail.com"
  member.password = "letmein"
  member.avatar.attach(io: URI.open(Faker::Avatar.image(slug: "my-own-slug", size: "50x50")), filename: "visitor#{i}.jpg")
  puts "Member not created. Errors: #{member.errors.full_messages}" unless member.save
  i +=1
end
