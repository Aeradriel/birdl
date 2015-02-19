# Use this hook to configure devise mailer, warden hooks and so forth.
# Many of these configuration options can be set straight in your model.
Devise.setup do |config|
  require 'devise/orm/active_record'

  config.mailer_sender = 'no-reply@birdl.com'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete

  # ==> OmniAuth
  # Add a new OmniAuth provider. Check the wiki for more information on setting
  # up on your models and hooks.
  # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'
  config.omniauth :facebook, '635859829894214',
                  'fb5c781e5ed229976be0269dc72b8761'
  config.omniauth :google_oauth2,
                  '672573300786-ejlc7anqtteekmh15a9veg8uc590jcu1.' \
                  'apps.googleusercontent.com',
                  '3zhOoiZDdh5m856ZetGpxI9j'
end
