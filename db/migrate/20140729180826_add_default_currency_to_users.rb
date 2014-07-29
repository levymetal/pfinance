class AddDefaultCurrencyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_currency, :string, :default => "AUD"
  end
end
