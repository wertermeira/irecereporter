web: bundle exec puma -C config/puma.rb
worker: RAILS_MAX_THREADS=${SIDEKIQ_RAILS_MAX_THREADS:-10} bundle exec sidekiq -C config/sidekiq.yml
release: rake db:migrate
