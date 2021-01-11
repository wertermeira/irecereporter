module Frontend
  class HomeController < ApplicationController
    def index
      @features = Post.feature_posts.feature_posts.order(id: :desc).limit(4)
    end
  end
end