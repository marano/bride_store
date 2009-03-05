# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bride_store_session',
  :secret      => '77baa5824481b2b44feca129a12b7fd63b3fdd5201c5ac1c12ae12e878697e63df263fed7b24d0e8b391a20cc9fd6092cf820b6fb28ee075c286aa2131d8b2cc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
