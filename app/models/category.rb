class Category < ActiveRecord::Base
  has_ancestry

  has_many :entries

  default_scope order('ancestry ASC')
end
