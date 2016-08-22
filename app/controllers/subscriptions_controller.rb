class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:edit, :update, :destroy, :activate, :pause]

  def index
    @subscriptions = SubscriptionDecorator.decorate_collection(current_user.subscriptions)
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = current_user.subscriptions.build(subscription_params)
    if @subscription.over_limit?
      flash[:error] = "Sorry, only two subscriptions per user are allowed at this time."
      redirect_to subscriptions_path
    elsif @subscription.save
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

  def activate
    verify_phone_number
  end

  def pause
    @subscription.toggle!(:active)
    redirect_to subscriptions_path
  end

  private

  def start_verification
    result = Nexmo::Client.new.send_verification_request(number: @subscription.phone_number, brand: "OpenManna")
    if result['status'] == '0'
      redirect_to edit_verification_path(id: result['request_id'], sub_id: @subscription.id)
    else
      redirect_to subscriptions_path
      flash[:error] = 'Could not verify your number. Please contact support.'
    end
  end

  def verify_phone_number
    start_verification if requires_verification?
  end

  def requires_verification?
    @subscription.active == false
  end

  def subscription_params
    params.require(:subscription).permit(:send_monday, :send_tuesday, :send_wednesday, :send_thursday, :send_friday, :send_saturday, :send_sunday, :send_hour, :time_zone, :phone_number, :name)
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
