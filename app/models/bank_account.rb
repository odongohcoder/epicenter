class BankAccount < PaymentMethod
  before_create :create_stripe_bank_account
  before_create :get_last_four_string
  after_update :create_verification

  attr_accessor :first_deposit, :second_deposit

  def calculate_fee(amount)
    0
  end

  def starting_status
    "pending"
  end

private

  def create_verification
    account = student.stripe_customer.sources.data.first
    begin
      account.verify(:amounts => [first_deposit.to_s, second_deposit.to_s])
      self.update!(verified: true)
      self.ensure_primary_method_exists
      self.save
      true
    rescue Stripe::StripeError => exception
      errors.add(:base, exception.message)
      false
    end
  end

  def create_stripe_bank_account
    student.stripe_customer.sources.create(:source => stripe_token)
  end

  def get_last_four_string
    begin
      customer = student.stripe_customer
      if customer.sources.data.first
        self.last_four_string = customer.sources.data.first.last4
      end
    rescue Stripe::StripeError => exception
      errors.add(:base, exception.message)
      false
    end
  end
end
