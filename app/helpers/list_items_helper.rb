module ListItemsHelper
  def description_tag(list_item)
    if list_item.url.present?
      "<a href=\"#{list_item.url}\">#{list_item.description}</a>"
    else
      list_item.description
    end
  end
end
