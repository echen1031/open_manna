class VerificationsController < ApplicationController
  def start
    @subscription = Subscription.find(params[:sub_id])
    verify_phone_number
  end

  def edit
  end
  
  def update
    confirmation = Nexmo::Client.new.check_verification_request(
      request_id: params[:id],
      code: params[:code]
    )

    if confirmation['status'] == '0'
      Subscription.find(params[:sub_id]).toggle!(:active)
      redirect_to subscriptions_path
      flash[:notice] = "Subscription successfully Activated."
    else
      redirect_to edit_verification_path(id: params[:id], sub_id: params[:sub_id]), flash: { error: confirmation['error_text'] }
    end
  end

  def verify_phone_number
    start_verification if requires_verification?
  end

  def start_verification
    result = Nexmo::Client.new.send_verification_request(number: @subscription.phone_number, brand: "OpenManna")
    if result['status'] == '0'
      redirect_to edit_verification_path(id: result['request_id'], sub_id: @subscription.id)
    else
      redirect_to subscriptions_path
      flash[:error] = 'Could not verify your number. Please contact support.'
    end
  end

  def requires_verification?
    @subscription.active == false
  end
end

