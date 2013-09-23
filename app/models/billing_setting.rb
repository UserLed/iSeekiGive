class BillingSetting < ActiveRecord::Base
  attr_accessible :card_last_four_digits, :card_holder_name, :card_expiry_date,
                  :card_type, :stripe_id, :stripe_token, :user_id
  attr_accessor :stripe_token

  belongs_to :user
  before_save :create_or_update_stripe_customer
  before_destroy :delete_stripe_customer

  def create_or_update_stripe_customer
    if stripe_token.present?
      if stripe_id.nil?
        customer = Stripe::Customer.create(
            :description => self.user.name,
            :email => self.user.email,
            :card => stripe_token
        )

        update_information customer

      else
        customer = Stripe::Customer.retrieve stripe_id
        customer.card = stripe_token
        customer.save

        update_information customer
      end
    end
  end

  def update_information customer
    self.card_last_four_digits = customer.cards.data.first.last4
    self.card_holder_name = customer.cards.data.first.name
    self.card_type = customer.cards.data.first.type
    card_expiry_date_string = "#{customer.cards.data.first.exp_year}-#{customer.cards.data.first.exp_month}-01"
    self.card_expiry_date = Date.parse(card_expiry_date_string).end_of_month
    self.stripe_id = customer.id
  end

  def transaction(amount, transaction_type)
    response = nil
    if transaction_type == 'deduct'
      logger.debug "===== Transaction started > amount(#{amount}) > type(#{transaction_type}) ====="
      response = Stripe::Charge.create(
          :amount => (amount.to_f * 100.0).to_i,
          :currency => "usd",
          :customer => customer,
          :description => "...billing..."
      )
    elsif transaction_type == 'add'
      # Yet to implement
      logger.debug "===== Transaction started > amount(#{amount}) > type(#{transaction_type}) ====="
    end
    logger.debug "===== Transaction finished. Response - #{response} ====="
    return response
  end

  def customer
    @customer ||= Stripe::Customer.retrieve self.stripe_id rescue nil
  end

  def delete_stripe_customer
    customer.delete
  end

end
