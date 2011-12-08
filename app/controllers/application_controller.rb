class ApplicationController < ActionController::Base
  include Clearance::Authentication
  protect_from_forgery
  
  $URL_REGEX = /(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix
end
