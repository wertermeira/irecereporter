module Backoffice
  class PostsController < ApplicationController
    def new; end

    def create
      @post = Post.new(post_params)
      if @post.save
        redirect_to backoffice_posts_path, notice: I18n.t('controller.messages.success.create')
      else
        render :new
      end
    end

    private

    def post_params
      params.require(:post).permit(:name, :subname, :headline, :cover, :image, :body, :active, :feature, :summary)
    end
  end
end
