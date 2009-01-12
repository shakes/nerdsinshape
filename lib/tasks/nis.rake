namespace :nis do
    desc "Updates the website from twitter.  Don't call too often!"
    task :update, :needs=>:environment do |t|
        Tweet.Update
        Status.Update
    end

    desc "Finds anyone who is friended to NerdsInShape and follows them"
    task :followers, :needs=>:environment do |t|
        twitter = Twitter::Base.new(TWITTER_USERNAME, TWITTER_PASSWORD)
        followers = twitter.followers.collect {|x| x.screen_name }
        twitter.friends.each do |u|
            if !followers.include?(u.screen_name)
                twitter.follow(u.screen_name)
                puts "Following #{u.screen_name}"
            end
        end
     end

    desc "Finds anyone who is following NerdsInShape and friends them"
    task :friends, :needs=>:environment do |t|
        twitter = Twitter::Base.new(TWITTER_USERNAME, TWITTER_PASSWORD)
        twitter.followers.each do |u|
            if !twitter.friendship_exists?(TWITTER_USERNAME, u.screen_name)
                begin
                    twitter.create_friendship(u.screen_name)
                    puts "Friended #{u.screen_name}"
                rescue Twitter::CantFollowUser 
                    puts "Unable to friend #{u.screen_name}"
                end
            end
        end
     end
end
