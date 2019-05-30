Magic::Link.configure do |config|
  config.user_class = "Member" # Default is User
  config.email_from = "admin@fanfaresintservatius.nl"
  config.token_expiration_hours = 6 # Default is 6
end