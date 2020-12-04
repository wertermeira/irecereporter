module Backoffice
  class AdminsController < ApplicationController
    before_action :set_admin, only: %i[show edit update destroy]

    def index
      @q = Admin.ransack(params[:q])
      @admins = @q.result.page(params[:page]).per(params[:size])
    end

    def show; end

    def new
      @admin = Admin.new
    end

    def create
      @admin = Admin.new(page_params)
      if @admin.save
        redirect_to backoffice_admins_path, notice: I18n.t('controller.messages.success.create')
      else
        render :new
      end
    end

    def edit; end

    def update
      if @admin.update(page_params)
        redirect_to backoffice_admins_path, notice: I18n.t('controller.messages.success.update')
      else
        render :edit
      end
    end

    def destroy
      @admin.destroy
      redirect_to backoffice_admins_path, notice: I18n.t('controller.messages.success.destroy')
    end

    private

    def set_admin
      @admin = Admin.find(params[:id])
    end

    def page_params
      params.require(:admin).permit(:name, :email, :password, :password_confirmation, :active, :profile)
    end
  end
end
