# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_captionize_session',
  :secret      => 'fcb9e09d2c4f097efeda6de36a5f0d587d86ab4bc4a8bd04a70a17af16c520716a2e3611c1104095e23a7da089b424d71f0e9d8954c4bbe02efdc2ebb07458d5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
