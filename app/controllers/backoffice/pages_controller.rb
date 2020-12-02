module Backoffice
  class PagesController < ApplicationController
    before_action :set_page, only: %i[show edit update destroy]

    def index
      @q = Page.ransack(params[:q])
      @pages = @q.result.page(params[:page]).per(params[:size])
    end

    def new
      @page = Page.new
    end

    def create
      @page = Page.new(page_params)
      if @page.save
        redirect_to backoffice_pages_path, notice: 'Criado com successo'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @page.update(page_params)
        redirect_to backoffice_pages_path, notice: 'Atualizado com successo'
      else
        render :edit
      end
    end

    def destroy
      @page.destroy
      redirect_to backoffice_pages_path, notice: 'Excluida com successo'
    end

    private

    def set_page
      @page = Page.friendly.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:name)
    end
  end
end