# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SJIFoodCoop_session',
  :secret      => 'c826f422c0c3d2c362ad97e4efa5c5e794fc90ffabf6183c14a678ba448a5e846f01f47c485064df05689dee14302caabcf85027d415a7e4a66d5e281928e543'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
