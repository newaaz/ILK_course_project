class ApplicationController < ActionController::Base
  include ActionView::Helpers::AssetUrlHelper
  include Pagy::Backend
  include Authorized  
  include NotFounded
  include Favorited
end
