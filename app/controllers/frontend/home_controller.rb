module Frontend
  class HomeController < FrontendController
    def index
      @features = Post.joins(:cover_attachment).feature_posts.order(id: :desc).limit(browser.device.mobile? ? 3 : 4)
      @top_posts = Post.top_hits(limit: browser.device.mobile? ? 5 : 10)
    end
  end
end
