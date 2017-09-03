module ApplicationHelper
  def active_class(page)
    case page
    when 'heroes'
      controller_name == 'heroes' ? 'active' : ''
    when 'about'
      (controller_name == 'about' && action_name == 'index') ? 'active' : ''
    when 'contact'
      (controller_name == 'about' && action_name == 'contact') ? 'active' : ''
    else
      ''
    end
  end
end
