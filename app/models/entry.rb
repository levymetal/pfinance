class Entry < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  before_save :convert_currency

  default_scope { order('date DESC, id DESC') }
  scope :expenses, -> { where(entry_type: 0) }
  scope :income, -> { where(entry_type: 1) }

  validates :from_amount, numericality: { greater_than: 0 }

  def convert_currency
    require 'open-uri'

    if self.currency == user.currency 
      self.amount = self.from_amount
    else
      convert_string = self.currency + user.currency
      xml = Nokogiri::XML(open("http://query.yahooapis.com/v1/public/yql?q=select%20%2a%20from%20yahoo.finance.xchange%20where%20pair%20in%20%28%22#{convert_string}%22%29&env=store://datatables.org/alltableswithkeys"))

      rate = xml.search('//rate').at_xpath('Rate').content.to_f

      self.amount = (self.from_amount * rate).round(2)
    end
  end
end
