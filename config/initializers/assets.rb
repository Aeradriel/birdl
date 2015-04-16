# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# coverage.js, coverage.css.scss, and all non-JS/CSS in app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( jquery-1.9.1.min.js )
Rails.application.config.assets.precompile += %w( jquery-easing.min.js )
Rails.application.config.assets.precompile += %w( event_search.js )
