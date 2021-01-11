module Backoffice
  class GalleriesController < BackofficeController
    before_action :set_gallery_item, only: %i[show destroy]

    def show
    end

    def create
      @gallery = Gallery.create(allery_params)
      if @gallery.save
        render json: @gallery, status: :created
      else 
        render json: @gallery.errors, status: :unprocessable_entity
      end
    end

    def destroy
      path = @gallery.post.present? ? backoffice_post_path(post) : backoffice_galleries_path
      @page.destroy
      redirect_to path, notice: 'Excluida com successo'
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