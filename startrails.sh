RAILS_ENV=production rake db:create db:migrate db:seed
rake secret
export SECRET_KEY_BASE=output-of-rake-secret
config.assets.compile = false to config.assets.compile = true
RAILS_ENV=production bundle exec rake assets:precompile
RAILS_ENV=production rails s
