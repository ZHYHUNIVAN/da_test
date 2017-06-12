#!/bin/sh
cd api/
bundle exec rake db:create db:migrate db:seed
rails s
