class User
  include MongoMapper::Document
  include Clearance::User
  
  key :username, String, :required => true
  key :email, String, :required => true
  key :encrypted_password, String, :limit => 128
  key :salt, String, :limit => 128
  key :confirmation_token, String, :limit => 128
  key :remember_token, String,:limit => 128
  timestamps!
  
end
