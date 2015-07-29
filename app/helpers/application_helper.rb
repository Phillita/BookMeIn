module ApplicationHelper
  def page_title(text = nil)
    content_for :title do
      "BookMeIn#{': ' + text if text}"
    end
  end
end
