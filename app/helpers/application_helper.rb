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

  def towns_hash
    Town.pluck(:id, :name).to_h
  end

  def categories_hash
    Category.pluck(:id, :title).to_h
  end
end
