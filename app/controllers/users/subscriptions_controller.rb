class Users::SubscriptionsController < ApplicationController
  before_filter :find_user

  def index
  end

  def new
    @subscription = Subscription.new
  end

  def create
    @subscription = current_user.subscriptions.build(subscription_params)
    if @subscription.save
      flash[:notice] = "Subscription created successfully."
      redirect_to [@user, @subscription]
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

  def find_user
    @user = User.find(params[:user_id])
  end
end
