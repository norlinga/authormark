module ApplicationHelper
  def home_link_icon
    return unless show_home_icon?

    link_to home_page_path,
      class: "group inline-block transition",
      title: "Back to Home",
      "aria-label": "Back to topic Home"  do
        content_tag :span,
          class: "text-blue-500 group-hover:text-blue-700 group-hover:drop-shadow-md transition duration-200 ease-in-out" do
          raw yield
        end
    end
  end

  def topic_context_link_icon
    return unless params[:topic_slug].present?

    link_to topic_path(params[:topic_slug]),
      class: "group inline-block transition",
      title: "Back to topic: #{params[:topic_slug].titleize}",
      "aria-label": "Back to topic: #{params[:topic_slug].titleize}" do
        content_tag :span,
          class: "text-blue-500 group-hover:text-blue-700 group-hover:drop-shadow-md transition duration-200 ease-in-out" do
          raw yield
        end
      end
  end

  def site_title
    SiteSetting["site_title"] || "My Site"
  end

  def copyright_text
    SiteSetting["copyright_text"] || "© #{Time.current.year}"
  end

  private

  def show_home_icon?
    current_page?(home_page_path) == false && request.path != "/index"
  end
end
