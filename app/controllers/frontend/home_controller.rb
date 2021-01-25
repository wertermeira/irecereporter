module Frontend
  class HomeController < FrontendController
    def index
      @features = Post.joins(:cover_attachment).feature_posts.feature_posts.order(id: :desc).limit(browser.device.mobile? ? 3 : 4)
    end
  end
end
