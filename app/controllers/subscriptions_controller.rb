class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:edit, :update, :destroy]

  def index
    @subscriptions = current_user.subscriptions
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = current_user.subscriptions.build(subscription_params)
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

  def update
    @subscription.update_attributes(subscription_params)

    if @subscription.save
      flash[:notice] = "Subscription updated successfully."
      redirect_to subscriptions_path
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    @subscription.destroy

    flash[:notice] = "Successfully removed subscription"
    redirect_to subscriptions_path
  end

  private

  def subscription_params
    params.require(:subscription).permit(:send_monday, :send_tuesday, :send_wednesdsay, :send_thursdsay, :send_friday, :send_saturday, :send_sunday, :send_hour, :time_zone, :phone, :name)
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
