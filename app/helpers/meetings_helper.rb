module MeetingsHelper
  def meetings_ajax_previous_link
    ->(param, date_range) { link_to raw("<<"), {param => date_range.first - 1.day}, remote: :true}
  end

  def meetings_ajax_next_link
    ->(param, date_range) { link_to raw(">>"), {param => date_range.last + 1.day}, remote: :true}
  end
end
