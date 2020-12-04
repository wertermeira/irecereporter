module Backoffice
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[show edit update destroy]

    def index
      @q = Category.ransack(params[:q])
      @categories = @q.result.page(params[:page]).per(params[:size])
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        redirect_to backoffice_categories_path, notice: 'Criado com sucesso'
      else
        render :new
      end
    end

    def edit; end

    def update
      if @category.update(category_params)
        redirect_to backoffice_categories_path, notice: 'Atualizado com sucesso'
      else
        render :edit
      end
    end

    def destroy
      @category.destroy
      redirect_to backoffice_categories_path, notice: 'Excluida com sucesso'
    end

    private

    def set_category
      @category = Category.friendly.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
  end
end
