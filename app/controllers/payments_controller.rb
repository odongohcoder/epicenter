class PaymentsController < ApplicationController
  authorize_resource
  before_filter :ensure_student_has_primary_payment_method, except: [:update]

  def index
    @student = Student.find(params[:student_id])

    authorize! :manage, @student
    if current_student && @student.upfront_payment_due?
      @payment = Payment.new(amount: @student.upfront_amount_with_fees)
    else current_admin
      @payment = Payment.new
    end
  end

  def create
    @student = Student.find(params[:student_id])
    @payment = Payment.new(payment_params)
    if @payment.save
      redirect_to student_payments_path(@student), notice: "Manual payment successfully made for #{@student.name}."
    else
      render 'index'
    end
  end

  def update
    @payment = Payment.find(params[:id])
    if @payment.update(payment_params)
      redirect_to student_payments_path(@payment.student), notice: "Refund successfully issued for #{@payment.student.name}."
    else
      @student = @payment.student
      render 'index'
    end
  end

private
  def payment_params
    format_refund_amount if params[:payment][:refund_amount]
    params.require(:payment).permit(:refund_amount, :amount, :student_id, :payment_method_id)
  end

  def format_refund_amount
    if params.dig(:payment, :refund_amount).include?('.')
      params.dig(:payment, :refund_amount).slice!('.')
    else
      params[:payment][:refund_amount] = params.dig(:payment, :refund_amount).to_i * 100
    end
  end

  def ensure_student_has_primary_payment_method
    student = Student.find(params[:student_id])
    if current_student && !student.primary_payment_method
      redirect_to payment_methods_path
    end
  end
end
