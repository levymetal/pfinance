class RemoveUseLastCurrencyFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :use_last_currency
  end
end
