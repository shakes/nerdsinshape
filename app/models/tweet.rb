class Tweet < ActiveRecord::Base
    belongs_to :user

    def self.Update
        all = find(:all)
        latest = find(:first, :order=>"tweeted_at DESC")
        new_tweets = Twitter::Search.new('#Nerds_In_Shape')
        if latest
            new_tweets = new_tweets.since(latest.tweet_id)
        end
        new_tweets.each do |r|
            t = new
            t.body = r['text']
            u = User.find_by_twitter_id(r['from_user_id'])
            if !u
                u = User.from_twitter(r['from_user_id'], r['from_user'])
            end
            if u
                t.user = u
                t.tweet_id = r['id']
                t.tweeted_at = r['created_at']
                t.save!
                puts "Updated tweet from #{r['from_user']}"
            end
        end

    end
end
