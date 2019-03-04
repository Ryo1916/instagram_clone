puts 'Start inserting seed users...'
user = User.create!(name: "Example User",
                    username: "exampleuser",
                    email: "example@railstutorial.org",
                    website: "https://railstutorial.jp",
                    bio: Faker::Lorem.sentence(6),
                    phone: 9910375368,
                    gender: 1,
                    avatar: File.open("#{Rails.root}/spec/fixtures/download.jpeg"),
                    password:              "password",
                    password_confirmation: "password")
puts "#{user.username} created!"
10.times do |n|
 user = User.create!({
    name: Faker::Name.name,
    username: Faker::Internet.unique.user_name,
    email: Faker::Internet.unique.email,
    website: Faker::Internet.url,
    bio: Faker::Lorem.sentence(6),
    phone: Faker::PhoneNumber.cell_phone.to_i,
    gender: 0,
    avatar: File.open("#{Rails.root}/spec/fixtures/avatar#{n+1}.png"),
    password:              "password",
    password_confirmation: "password"
  })

  puts "#{user.username} created!"
end

puts "Start inserting seed posts..."
users = User.order(:created_at).take(6)
10.times do |n|
  users.each do |user|
    post = user.posts.create!({
      image: File.open("#{Rails.root}/spec/fixtures/post#{n+1}.jpg"),
      content: Faker::Lorem.sentence(5)
    })

    puts "#{post.user.username}'s post created!"
  end
end

puts "Start inserting seed relationships..."
users = User.all
user  = users.first
following = users[2..10]
followers = users[3..10]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

puts "Start inserting seed likes..."
users = User.all
liking_users = users[2..10]
like_posts = Post.all
like_posts.each do |like_post|
  liking_users.each do |liking_user|
    like_post.like(liking_user)
  end
end

puts "Start inserting seed comments..."
users = User.all
commenting_users = users[2..10]
posts = Post.all
commenting_users.each do |commenting_user|
  posts.each do |post|
    post.comments.create!(
      text: Faker::Lorem.sentence(6),
      user_id: commenting_user.id
    )
    puts "#{commenting_user}\'s comment created!"
  end
end

puts "Finish inserting seed!"
