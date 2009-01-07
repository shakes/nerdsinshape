class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :body, :limit=>140, :null=>false
      t.integer :user_id, :null=>false
      t.string :tweet_id, :null=>false
      t.datetime :tweeted_at

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
