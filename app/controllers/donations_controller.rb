class DonationsController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:checkout_session, :manage]

  def new
    @basic_price_id = ENV['BASIC_PRICE_ID']
    @premium_price_id = ENV['PREMIUM_PRICE_ID']
  end

  def checkout_session
    unless current_user.stripe_customer_id.present?
      customer = Stripe::Customer.create({
        email: current_user.email
      })
      current_user.update_columns(stripe_customer_id: customer.id)
    end

    session = Stripe::Checkout::Session.create({
      line_items: [{
        # Provide the exact Price ID (e.g. pr_1234) of the product you want to sell
        price: params["price_id"],
        quantity: 1,
      }],
      mode: 'subscription',
      customer: current_user.stripe_customer_id,
      success_url: subscriptions_url,
      cancel_url: root_url,
    })
    redirect_to session.url
  end

  def manage
    portal = Stripe::BillingPortal::Session.create({
      customer: current_user.stripe_customer_id,
      return_url: subscriptions_url,
    })

    redirect_to portal["url"]
  end

  def create
    @amount = params[:amount]

    @amount = @amount.gsub('$', '').gsub(',', '')

    begin
      @amount = Float(@amount).round(2)
    rescue
      flash[:error] = 'Charge not completed. Please enter a valid amount in USD ($).'
      redirect_to new_charge_path
      return
    end

    @amount = (@amount * 100).to_i # Must be an integer!

    if @amount < 500
      flash[:error] = 'Charge not completed. Donation amount must be at least $5.'
      redirect_to new_charge_path
      return
    end

    Stripe::Charge.create(
      :amount => @amount,
      :currency => 'usd',
      :source => params[:stripeToken],
      :description => 'Custom donation'
    )

    flash[:notice] = "Thank you! Your donation of #{view_context.number_to_currency(@amount * 0.01)} has been received."
    redirect_to root_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

end
