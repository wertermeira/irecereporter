module ApplicationHelper
  def menu_current_link
    'active'
  end

  def resize_image_feature_options(index = 0)
    if browser.device.mobile? && index != 0
      combine_options(resize: '500x250^', extent: '500x250')
    else
      combine_options(resize: '555x495^', extent: '555x495')
    end
  end

  def combine_options(resize: '555x289^', extent: '555x289', gravity: 'Center')
    { resize: resize, extent: extent, gravity: gravity }
  end

  def by_category(slug)
    Category.find_by(slug: slug)
  end
end
