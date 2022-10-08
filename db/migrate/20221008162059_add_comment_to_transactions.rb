class AddCommentToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :comment, :text
  end
end
