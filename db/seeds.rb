require "net/http"

User.destroy_all
Post.destroy_all
Follow.destroy_all


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

user_ids = User.all.map { |user| user.id }

# Posts seeds
User.all.each do |u|
    50.times do
      while true
        url = URI.parse("https://i.picsum.photos/id/#{(1..1084).to_a.sample}/300/300.jpg")
        req = Net::HTTP.new(url.host, url.port)
        req.use_ssl = true
        res = req.request_head(url.path)
        if res.code == "200"
          post = Post.create(title: Faker::Quote.famous_last_words, image: url, user_id: u.id)
          puts "#{Post.count} posts created"
          break
        else
          puts "ERROR 404 LOOK AGAIN!!!"
        end
      end
    end
end

post_ids = Post.all.map { |post| post.id }


end_time = Time.now
puts "total time taken #{(end_time - start_time).round(2)} seconds"
