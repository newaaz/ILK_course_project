module ApplicationHelper
  def full_title(page_title = '')
    base_title = "Люблю Крым"
    if page_title.empty?
      base_title
    else
      # page_title + " | " + base_title
      page_title
    end
  end
end
