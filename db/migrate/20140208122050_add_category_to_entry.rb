class AddCategoryToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :category_id, :integer
  end
end
