RAILS_ENV=production bundle exec rake assets:precompile
/usr/local/rvm/gems/ruby-1.9.3-p429/bin/passenger stop -p 80
/usr/local/rvm/gems/ruby-1.9.3-p429/bin/passenger start -p 80 -d -e production
