module ApplicationHelper
	# Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "LET'S"
    if page_title.empty?
      base_title
    else
      base_title + " " + page_title
    end
  end

  def gender i
  	return "male" if i == 1
  	return "female" if i == 2
  	return "unisex" if i == 0
  end

  

end
