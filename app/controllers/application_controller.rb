class ApplicationController < ActionController::Base
  include Authorized
  include Pagy::Backend
end
