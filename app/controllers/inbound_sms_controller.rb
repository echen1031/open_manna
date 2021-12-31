class InboundSmsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:message_status_webhook, :inbound_message_webhook]

  def message_status_webhook
    head :ok
  end

  def inbound_message_webhook
    if params['keyword'] == 'STOP'
      sub = Subscription.find_by(phone_number: '+' + params["msisdn"])
      if sub.present? && sub.active == true
        sub.update_columns(active: false)
        SMSClient.new.send_message(
          to: sub.phone_number,
          text: 'Successfully stopped subscription. Reply START to resume'
        )
      end
    elsif params['keyword'] == 'START'
      sub = Subscription.find_by(phone_number: '+' + params["msisdn"])
      if sub.present? && sub.active == false && sub.verified == true
        sub.update_columns(active: true)
        SMSClient.new.send_message(
          to: sub.phone_number,
          text: 'Successfully resumed subscription. Reply STOP to stop'
        )
      end
    end
    head :ok
  end
end
