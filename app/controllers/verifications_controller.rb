class VerificationsController < ApplicationController
  def edit
  end
  
  def update
    confirmation = Nexmo::Client.new.check_verification_request(
      request_id: params[:id],
      code: params[:code]
    )

    if confirmation['status'] == '0'
      session[:verified] = true
      redirect_to subscriptions_path
      flash[:notice] = "Subscription successfully Activated."
    else
      redirect_to edit_verification_path(id: params[:id]), flash: { error: confirmation['error_text'] }
    end
  end
end

