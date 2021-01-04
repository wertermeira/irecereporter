# frozen_string_literal: true

module Ckeditor
  class Asset < ActiveRecord::Base
    include Ckeditor::Orm::ActiveRecord::AssetBase
    include Ckeditor::Backend::ActiveStorage

    attr_accessor :data

    has_one_attached :storage_data
  end
end
