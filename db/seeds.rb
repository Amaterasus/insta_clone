require "net/http"

User.destroy_all
Post.destroy_all
Like.destroy_all
Follow.destroy_all
Comment.destroy_all
Faker::UniqueGenerator.clear

start_time = Time.now

skye = User.create(user_name: "skye", bio: "Overachieving coder", password: "cat")
nick = User.create(user_name: "nick", bio: "Greek Man", password: "cat")
dinno = User.create(user_name: "dinno", bio: "Man in lockdown", password: "cat")

Follow.create(follower: nick, followee: skye)
Follow.create(follower: nick, followee: dinno)
Follow.create(follower: skye, followee: nick)
Follow.create(follower: skye, followee: dinno)
Follow.create(follower: dinno, followee: nick)
Follow.create(follower: dinno, followee: skye)

# User Seeds
250.times do
  user = User.create(user_name: Faker::Name.unique.first_name.downcase, bio: Faker::Movies::StarWars.quote, password: "cat")
  puts "#{user.user_name} created"
end

user_ids = User.all.map { |user| user.id }

# Posts seeds
5000.times do
  while true
    url = URI.parse("https://i.picsum.photos/id/#{(1..1084).to_a.sample}/300/300.jpg")
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = true
    res = req.request_head(url.path)
    if res.code == "200"
      post = Post.create(title: Faker::Quote.famous_last_words, image: url, user_id: user_ids.sample)
      puts "#{Post.count} posts created"
      break
    else
      puts "ERROR 404 LOOK AGAIN!!!"
    end
  end
end

post_ids = Post.all.map { |post| post.id }

# Follow seeds

User.all.each do |u|
  x = []
  100.times do
    x << user_ids.sample
  end
  if x.include?(u.id)
    x.delete(u.id)
  end
  x.uniq.each do |user|
    Follow.create(follower_id: user, followee_id: u.id)
    puts "#{Follow.count} follows created"
  end
end

# Like seeds

Post.all.each do |post|
  5.times do
    x = post.user.followers.sample
    if Like.where(post: post, user: x).size == 0
      like = Like.create(post: post, user: x)
    end
    puts "#{Like.count} likes created"
  end
end

# Comment seeds

15000.times do
  comment = Comment.create(user_id: user_ids.sample, post_id: post_ids.sample, content: Faker::Movie.quote)
  puts "#{Comment.count} comments created"
end

end_time = Time.now
puts "total time taken #{(end_time - start_time).round(2)} seconds"
