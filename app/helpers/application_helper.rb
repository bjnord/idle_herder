module ApplicationHelper
  def active_class(page)
    case page
    when 'heroes'
      controller_name == 'heroes' ? 'active' : ''
    when 'accounts'
      (controller_name == 'accounts' && action_name == 'show') ? 'active' : ''
    when 'materials'
      (controller_name == 'accounts' && action_name == 'materials') ? 'active' : ''
    when 'goals'
      (controller_name == 'accounts' && action_name == 'goals') ? 'active' : ''
    when 'about'
      (controller_name == 'about' && action_name == 'index') ? 'active' : ''
    when 'contact'
      (controller_name == 'about' && action_name == 'contact') ? 'active' : ''
    else
      ''
    end
  end

  def title(text)
    content_for :title, text
  end
  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def empty_integer(value)
    if value.blank? || (value == 0)
      return nil
    end
    value
  end
end
