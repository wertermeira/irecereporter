class FrontendController < ActionController::Base
  before_action :set_categories

  private

  def set_categories
    @categories = Category.order(name: :asc).all
  end
end
