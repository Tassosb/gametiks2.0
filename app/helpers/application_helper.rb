module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Gametiks: Official Tally for Wild Game Harvest"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && title == "OLDEST" ? "asc" : "desc"
    link_to title, {:sort => column, :direction => direction}
  end

end
