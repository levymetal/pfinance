module ApplicationHelper
  def nav_link(link_text, link_path, class_name)
    class_name += current_page?(link_path) ? ' active' : ''

    link_to link_text, link_path, :class => class_name      
  end

  def number_format(num)
    if current_user.id == 1
      "$#{number_with_precision(num, precision: 2)}"
    else
      "£#{number_with_precision(num, precision: 2)}"
    end
  end
end
