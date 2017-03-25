class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])

      $ad         = current_user.ads.build
      $ads_feed   = current_user.ads_feed
    end
  end

  def help
  end

  def about
  end
end
