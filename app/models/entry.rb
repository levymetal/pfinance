class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  default_scope order('date DESC')

  def root_category
    category.root? ? category : category.parent
  end
end
