File.open("#{RAILS_ROOT}/.twitter_account_info") do |f|
    TWITTER_USERNAME = f.gets
    TWITTER_PASSWORD = f.gets
end
