module ApplicationHelper
  def currencies
    currencies = { 'AUD' => '$', 
                   'GBP' => '£', 
                   'USD' => '$'
                 }
  end

  def nav_link(link_text, link_path, class_name)
    class_name += current_page?(link_path) ? ' active' : ''

    link_to link_text, link_path, :class => class_name      
  end

  def number_format(num)
    if num < 10
      "#{currencies[current_user.currency]}#{number_with_precision(num, precision: 2)}"
    else
      "#{currencies[current_user.currency]}#{number_with_precision(num, precision: 0)}"
    end
  end

  def link_to_back(page)
    class_name = 'icon-chevron-left' + ( page ? '' : ' hidden' )
    link_to '', page, :class => class_name
  end
end
