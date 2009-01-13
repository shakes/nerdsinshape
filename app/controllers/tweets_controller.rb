class TweetsController < ApplicationController
    def index
        @tweets = Tweet.paginate(:all,
                                 :page=>params[:page],
                                 :order=>"tweeted_at DESC")
    end

    def log
        @tweets = Tweet.find(:all, :order=>"tweeted_at DESC")
    end
end
