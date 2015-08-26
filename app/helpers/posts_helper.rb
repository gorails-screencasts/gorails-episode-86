module PostsHelper
  def status_for(post)
    if post.published_at?
      if post.published_at > Time.zone.now
        "Scheduled"
      else
        "Published"
      end
    else
      "Draft"
    end
  end
end
