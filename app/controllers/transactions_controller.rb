class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show destroy ]

  # GET /transactions
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new(transaction_params)
    @deposit = ActiveModel::Type::Boolean.new.cast(transaction_params[:deposit])

  end

  # POST /transactions
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to @transaction, notice: "Transaction was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /transactions/1
  def destroy
    new_transaction = Transaction.new(
      amount: @transaction.amount,
      comment: 'Deletes a previous transaction',
      deposit: !@transaction.deposit,
      executor: 'The system'
    )
    if new_transaction.save
      redirect_to transactions_url, notice: "Transaction was successfully reverted."
    else
      render :index, status: :unprocessable_entity
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      params.require(:transaction).permit(:amount, :comment, :deposit, :executor)
    end
end
