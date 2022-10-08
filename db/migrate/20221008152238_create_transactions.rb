class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.boolean :deposit
      t.string :executor

      t.timestamps
    end
  end
end
