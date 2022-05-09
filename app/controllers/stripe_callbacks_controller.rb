class StripeCallbacksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:callbacks]

  def callbacks
    payload = request.body.read
    endpoint_secret = ENV['STRIPE_ENDPOINT_SECRET']
    event = nil

    # Verify webhook signature and extract the event
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError
      # Invalid payload
      render json: { error: 'invalid payload' }, status: 400
      return
    rescue Stripe::SignatureVerificationError
      # Invalid signature
      render json: { error: 'invalid signature' }, status: 400
      return
    end
    event_type = event['type']
    data = event['data']
    data_object = data['object']

    if event_type == 'invoice.paid'
      user = User.find_by(stripe_customer_id: data_object.customer)
      product = Product.find_by(external_id: data_object.lines.data[0].price.id)
      if user.present? && product.present?
        user.plan.update_columns(product_id: product.id)
        user.update_columns(plan_period_end: data_object.lines.data[0].period.end)
        user.plan.activate! if user.plan.aasm_state != 'active'
      end
    end

    render json: { status: 'success' }, status: 200
  end
end
