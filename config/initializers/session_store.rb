# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cchh_session',
  :secret      => '868a151141ddb24879907ff0291b0079cd809be842920cf9ae0c0724b4346233e4cc7ebef1f77d6c033b18b5644e8d42fcda06ce955a6abed1846090092d5d0a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
