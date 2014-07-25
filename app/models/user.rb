class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :entries
  has_many :categories

  after_create :seed_categories

  def seed_categories
    food = self.categories.create(:name => 'Food')
    self.categories.create(:name => 'Breakfast', :parent => food)
    self.categories.create(:name => 'Lunch', :parent => food)
    self.categories.create(:name => 'Dinner', :parent => food)
    self.categories.create(:name => 'Groceries', :parent => food)

    utilities = self.categories.create(:name => 'Utilities')
    self.categories.create(:name => 'Internet', :parent => utilities)
    self.categories.create(:name => 'Phone', :parent => utilities)

    car = self.categories.create(:name => 'Car')
    self.categories.create(:name => 'Fuel', :parent => car)
    self.categories.create(:name => 'Insurance', :parent => car)
    self.categories.create(:name => 'Rego', :parent => car)
    self.categories.create(:name => 'Maintenance', :parent => car)

    income = self.categories.create(:name => 'Income')
    self.categories.create(:name => 'Salary', :parent => income)
    self.categories.create(:name => 'Other', :parent => income)
  end
end
