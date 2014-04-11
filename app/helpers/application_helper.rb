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
    "#{currencies[current_user.currency]}#{number_with_precision(num, precision: 2)}"
  end

  def link_to_back
    if request.referer
      link_to '', request.referer, :class => 'icon-chevron-left'
    else
      render(:inline => "<div></div>")
    end
  end
end
