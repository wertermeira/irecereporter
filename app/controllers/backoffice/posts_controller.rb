module Backoffice
  class PostsController < ApplicationController
    before_action :set_post, only: %i[update edit show destroy]
    before_action :set_categories_and_pages, only: %i[edit new create update]

    def index
      @q = Post.ransack(params[:q])
      @posts = @q.result.page(params[:page]).per(params[:size])
    end

    def show; end
    
    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      if @post.save
        redirect_to backoffice_posts_path, notice: I18n.t('controller.messages.success.create')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @post.update(post_params)
        redirect_to backoffice_posts_path, notice: I18n.t('controller.messages.success.update')
      else
        render :edit
      end
    end

    def destroy
      @post.destroy
      redirect_to backoffice_posts_path, notice: I18n.t('controller.messages.success.destry')
    end

    private

    def set_post
      @post = Post.friendly.find(params[:id])
    end

    def set_categories_and_pages
      @categories = Category.all.order(name: :asc)
      @pages = Page.all.order(name: :asc)
    end

    def post_params
      params.require(:post).permit(:name, :subname, :headline,
                                   :cover, :image, :body, :active,
                                   :feature_post, :summary, :tag_list, :page_id, category_ids: [])
    end
  end
end
