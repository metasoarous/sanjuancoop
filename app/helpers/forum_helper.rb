module ForumHelper
  def display_post(post)
    html = "<p>\n"
    post.body.lines.each do |line|
      if line == "\r"
        html += "</p>\n<p>"
      else
        html += line + "<br />"
      end
    end
    return html + "</p>"
  end
end