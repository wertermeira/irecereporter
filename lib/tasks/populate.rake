namespace :populate do
  include FactoryBot::Syntax::Methods if Rails.env.development?

  desc 'Populete pages'
  task pages: :environment do
    rand(20..50).times do
      create(:page)
    end
  end
end
