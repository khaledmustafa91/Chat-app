#! /bin/bash
bundle
rails db:exists && rails db:migrate || rails db:setup
rake

