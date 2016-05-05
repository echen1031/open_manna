class SubscriptionsController < ApplicationController
  def index
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user = current_user
    if @subscription.save
      flash[:notice] = "Subscription created successfully."
      redirect_to subscriptions_path
    else
      flash[:error] = "Subscription could not be saved."
      render action: :new
    end
  end

  def show
  end

  def edit
  end

  private

  def subscription_params
    params.require(:subscription).permit(:send_day_1, :send_day_2, :send_day_3, :send_day_4, :send_day_5, :send_day_6, :send_day_7, :send_hour, :time_zone, :phone)
  end
end
