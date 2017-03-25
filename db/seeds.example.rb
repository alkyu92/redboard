# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Admin First",
             email: "admin@railstutorial.org",
             password:              "admin123",
             password_confirmation: "admin123",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

User.create!(name:  "Admin Second",
            email: "admintwo@a.a",
            password:              "admin456",
            password_confirmation: "admin456",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

#microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each {|user| user.microposts.create!(content: content, like: 50, comment: 40, share: 30)}
end

#ads
admins = User.where(admin: true)
50.times do
  ad_title = Faker::Lorem.sentence(5)
  ad_description = Faker::Lorem.sentence(10)
  ad_date = Faker::Time.forward(10, :morning)
  ad_time = Faker::Time.forward(10, :morning)
  ad_venue = Faker::Address.street_address

  admins.each {
    |admin| admin.ads.create!(
      ad_title: ad_title,
      ad_description: ad_description,
      ad_date: ad_date,
      ad_time: ad_time,
      ad_venue: ad_venue
      )}
end

#blogs
users = User.order(:created_at).take(6)
50.times do
  blog_content = Faker::Lorem.sentence(1000)
  blog_title = Faker::Lorem.sentence(5)
  blog_subtitle = Faker::Lorem.sentence(10)
  users.each {|user| user.blogs.create!(blog_content: blog_content,
                                        blog_title: blog_title,
                                        blog_subtitle: blog_subtitle)}
end

#FAQ
users = User.find_by(admin: true)
10.times do
  content = Faker::Lorem.sentence(100)
  title = Faker::Lorem.sentence(10) + "?"
  users.faqs.create!(content: content, title: title)
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
