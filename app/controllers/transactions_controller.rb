class TransactionsController < ApplicationController
  class AuthenticationError < StandardError; end
  class UnprocessableEntity < StandardError; end

  before_action :set_transaction, only: %i[ show destroy ]
  before_action :authenticate, only: :create

  # GET /transactions
  def index
    @transactions = Transaction.get_last_five
    @hide_transactions_menu_item = true
  end

  # GET /transaction/1
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new(transaction_params)
    @deposit = ActiveModel::Type::Boolean.new.cast(transaction_params[:deposit])
  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params.except(:secret_code))
    raise UnprocessableEntity unless @transaction.save
    redirect_to transactions_url, notice: "Transaction was successfully created."
  end

  # DELETE /transactions/1
  def destroy
    if @transaction.cancels_out
      other_transaction = @transaction.cancels_out
      if @transaction.created_at > other_transaction.created_at
        @transaction.destroy
        raise UnprocessableEntity unless other_transaction.update(cancels_out: nil)
      else
        other_transaction.destroy
        raise UnprocessableEntity unless @transaction.update(cancels_out: nil)
      end
      redirect_to transactions_url, notice: "Transaction was successfully restored."

    else
    new_transaction = Transaction.new(
      amount: @transaction.amount,
      cancels_out: @transaction,
      comment: 'Deletes a previous transaction',
      deposit: !@transaction.deposit,
      executor: 'The system'
    )
    raise UnprocessableEntity unless new_transaction.save
    raise UnprocessableEntity unless @transaction.update(cancels_out: new_transaction)
    redirect_to transactions_url, notice: "Transaction was successfully reverted."
    end
  end

  private

    def authenticate
      raise AuthenticationError unless transaction_params[:secret_code] == ENV["SECRET_CODE"]
    end

    def rescue_unprocessable
      render :index, status: :unprocessable_entity
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(
        :amount,
        :comment,
        :deposit,
        :executor,
        :secret_code
      )
    end
end
