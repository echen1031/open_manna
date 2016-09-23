class VerificationsController < ApplicationController
  def start
    @subscription = Subscription.find(params[:sub_id])
    start_verification unless @subscription.active?
  end

  def start_verification
    result = VerificationRequestSender.new(@subscription.phone_number)
    if result.send_successful_request?
      redirect_to edit_verification_path(id: result.request_id, sub_id: @subscription.id)
    else
      redirect_to subscriptions_path
      flash[:error] = 'Could not verify your number. Please contact support.'
    end
  end

  def edit
  end
  
  def update
    result = VerificationRequestChecker.new(params[:id], params[:code])

    if result.phone_number_confirmed?
      sub = Subscription.find(params[:sub_id])
      sub.toggle!(:active)
      SMSClient.new.send_welcome_message(to: sub.phone_number) if sub.new_subscription?
      redirect_to subscriptions_path
      flash[:notice] = "Subscription successfully Activated."
    else
      redirect_to edit_verification_path(id: params[:id], sub_id: params[:sub_id]), flash: { error: result.error_text }
    end
  end
end

