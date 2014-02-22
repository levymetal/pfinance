class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  default_scope { order('date DESC, id DESC') }
end
