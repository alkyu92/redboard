class AdsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
      @ad = current_user.ads.build(ad_params)
      if @ad.save
          flash[:success] = 'Ads created!'
          redirect_to root_url
      else
          @ads_feed = []
          render 'static_pages/home'
      end
  end

  def destroy
      @ad.destroy
      flash[:success] = 'Ads deleted!'
      redirect_to request.referrer || root_url
  end

  def show
  end

  private

  def ad_params
      params.require(:ad).permit( :ad_title,
                                  :ad_description,
                                  :ad_time,
                                  :ad_venue,
                                  :ad_date)
  end

  def correct_user
      @ad = current_user.ads.find_by(id: params[:id])
      redirect_to root_url if @ad.nil?
  end
end
