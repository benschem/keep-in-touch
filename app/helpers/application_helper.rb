module ApplicationHelper
  def render_icon(icon, options = {})
    classes = options[:classes] ||= ""
    height = options[:size] ||= "20px"
    width = options[:size] ||= "20px"

    render "icons/#{icon}", classes:, height:, width:
  end
end
