class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Authorized  
  include NotFounded
  include Favorited
end
