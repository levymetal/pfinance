class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :user, index: true
      t.decimal :amount
      t.datetime :date

      t.timestamps
    end
  end
end
