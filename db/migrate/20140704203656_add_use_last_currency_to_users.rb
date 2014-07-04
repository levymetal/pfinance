class AddUseLastCurrencyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :use_last_currency, :boolean, :default => false
  end
end
