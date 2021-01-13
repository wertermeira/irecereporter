module Frontend
  class PostsController < FrontendController
    before_action :set_post, only: :show

    def index
      @q = Post.published.ransack(params[:q])
      @q.sorts = 'id desc' if @q.sorts.empty?
      @posts = @q.result.page(params[:page]).per(params[:size])
    end

    def show
    end

    private

    def set_post
      @post = Post.published.friendly.find(params[:slug])
    end
  end
end