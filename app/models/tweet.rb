class Tweet < ActiveRecord::Base
    belongs_to :user

    def self.Update
        all = find(:all)
        latest = find(:first, :order=>"tweeted_at DESC")

        twitter = Twitter::Base.new(TWITTER_USERNAME, TWITTER_PASSWORD)
        new_tweets = nil
        if latest
            new_tweets = twitter.timeline(:friends, :since_id=>latest.tweet_id)
        else
            new_tweets = twitter.timeline(:friends)
        end
        new_tweets.each do |r|
            if r.text.index("#Nerds_In_Shape")
                t = new
                t.body = r.text
                u = User.find_by_twitter_id(r.user.id)
                if !u
                    u = User.from_twitter(r.user.id, r.user.screen_name)
                end
                if u
                    t.user = u
                    t.tweet_id = r.id
                    t.tweeted_at = r.created_at
                    t.save!
                    puts "Updated tweet from #{r.user.screen_name}"
                end
            end
        end

    end
end
