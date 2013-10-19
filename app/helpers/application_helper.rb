module ApplicationHelper
  def active_link_to(link_text, link_path, request_path, icon_mode = false)
    if icon_mode == true
      link_to link_text, link_path, class: request_path == link_path ? "icon icon-#{link_path.gsub("/", "").dasherize} active" : "icon icon-#{link_path.gsub("/", "").dasherize}"
    else
      link_to link_text, link_path, class: request_path == link_path ? "active" : ""
    end
  end
end
