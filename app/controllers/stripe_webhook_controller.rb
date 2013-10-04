class StripeWebhookController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def create
    begin
      types = %w(charge.succeeded charge.failed charge.refunded charge.dispute.created charge.dispute.updated charge.dispute.closed)

      if types.include?(params["type"])
        payment = Payment.find_by_transaction_id(params["data"]["object"]["id"])
        if payment
          paid = params["data"]["object"]["paid"]
          if paid
            payment.status = "paid"
            payment.save!
          end
        end

        Rails.logger.debug "##### #{params.inspect} #####"
      end
    rescue => e
      error = e
    end

    respond_to do |format|
      if error.blank?
        format.any { render :text => "SUCCESS", :status => :ok }
      else
        format.any { render :text => "ERROR", :status => :bad_request }
      end
    end
  end
end