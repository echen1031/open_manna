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
    params.require(:subscription).permit(:send_monday, :send_tuesday, :send_wednesdsay, :send_thursdsay, :send_friday, :send_saturday, :send_sunday, :send_hour, :time_zone, :phone)
  end
end
