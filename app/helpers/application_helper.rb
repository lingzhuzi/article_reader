module ApplicationHelper
  def menu_style(controller_name)
    params[:controller] == controller_name ? 'active' : ''
  end
end
