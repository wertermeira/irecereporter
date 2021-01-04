module Backoffice
  class BannersController < BackofficeController
    before_action :set_banner, only: %i[show edit update destroy]

    def index
      @q = Banner.ransack(params[:q])
      @banners = @q.result.page(params[:page]).per(params[:size])
    end

    def show; end

    def new
      @banner = Banner.new
    end

    def create
      @banner = Banner.new(page_params)
      if @banner.save
        redirect_to backoffice_banners_path, notice: I18n.t('controller.messages.success.create')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @banner.update(page_params)
        redirect_to backoffice_banners_path, notice: I18n.t('controller.messages.success.update')
      else
        render :edit
      end
    end

    def destroy
      @banner.destroy
      redirect_to backoffice_banners_path, notice: I18n.t('controller.messages.success.destroy')
    end

    private

    def set_banner
      @banner = Banner.find(params[:id])
    end

    def page_params
      params.require(:banner).permit(:name, :banner, :date_start, :date_end, :kind, :active)
    end
  end
end
