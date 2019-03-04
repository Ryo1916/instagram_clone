module ApplicationHelper
  APP_NAME = 'Instagram'

  def page_title(title = '')
    base_title = APP_NAME
    return base_title if title.blank?
    "#{base_title} | #{title}"
  end
end
