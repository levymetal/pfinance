class AddCurrencyToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :currency, :string, :default => "AUD"
    add_column :entries, :from_amount, :decimal
  end
end
