class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription, only: [:edit, :update, :destroy, :pause]
  before_action :validate_ownership, only: [:edit, :update, :destroy, :pause]
  before_action :check_subscription_limit, only: [:create]

  def index
    @subscriptions = SubscriptionDecorator.decorate_collection(current_user.subscriptions)
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = current_user.subscriptions.build(subscription_params)
    if @subscription.save
      flash[:notice] = "Subscription created successfully."
      redirect_to subscriptions_path, flash: { activation_modal: true, sub_id: @subscription.id }
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

  def pause
    @subscription.toggle!(:active)
    redirect_to subscriptions_path
  end

  private

  def subscription_params
    params.require(:subscription).permit(:send_monday, :send_tuesday, :send_wednesday, :send_thursday, :send_friday, :send_saturday, :send_sunday, :send_hour, :time_zone, :phone_number, :name)
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def check_subscription_limit
    if current_user.over_subscription_limit?
      flash[:error] = "Sorry, only two subscriptions per user are allowed at this time."
      redirect_to subscriptions_path
    end
  end

  def validate_ownership
    if current_user != @subscription.user
      redirect_to subscriptions_path
    end
  end
end
