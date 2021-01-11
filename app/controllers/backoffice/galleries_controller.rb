module Backoffice
  class GalleriesController < BackofficeController
    before_action :set_gallery_item, only: %i[show destroy]
    skip_before_action :verify_authenticity_token, only: :create

    def show
      render layout: false
    end

    def create
      @gallery = Gallery.create(gallery_params)
      if @gallery.save
        render json: @gallery, status: :created
      else
        render json: @gallery.errors, status: :unprocessable_entity
      end
    end

    def destroy
      post = @gallery.post
      @gallery.destroy
      redirect_to backoffice_post_path(post), notice: 'Excluida com successo'
    end

    private

    def set_gallery_item
      @gallery = Gallery.find(params[:id])
    end

    def gallery_params
      params.require(:gallery).permit(:post_id, :image)
    end
  end
end
