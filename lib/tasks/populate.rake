namespace :populate do
  include FactoryBot::Syntax::Methods if Rails.env.development?

  desc 'Populete pages'
  task pages: :environment do
    rand(20..50).times do
      page = create(:page)
      p page.name
    end
  end

  desc 'Populete categoies'
  task categories: :environment do
    rand(10..30).times do
      category = create(:category)
      p category.name
    end
  end

  desc 'Populete Admins'
  task admins: :environment do
    rand(20..50).times do
      create(:admin)
    end
  end

  desc 'Populete banners'
  task banners: :environment do
    rand(20..50).times do
      banner = create(:banner)
      p banner
    end
  end
end
