namespace :nis do
    desc "Updates the website from twitter.  Don't call too often!"
    task :update, :needs=>:environment do |t|
        Tweet.Update
        Status.Update
    end
end
