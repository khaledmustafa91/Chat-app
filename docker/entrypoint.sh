#! /bin/bash
/wait
bundle exec rails db:exists && rails db:migrate || rails db:create db:migrate

puma -C config/puma.rb
