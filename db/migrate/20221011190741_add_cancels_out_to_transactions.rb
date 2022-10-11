class AddCancelsOutToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_reference :transactions, :cancels_out, default: nil , foreign_key: { to_table: :transactions }
  end
end
