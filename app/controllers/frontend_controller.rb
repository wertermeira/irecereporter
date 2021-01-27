class FrontendController < ActionController::Base
  before_action :set_categories

  private

  def set_categories
    @categories = Category.only_home.order(name: :asc).all
  end
end
