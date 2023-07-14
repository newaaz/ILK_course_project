class Admin::PropertiesController < Admin::BaseController
  def index
    @properties = Property.all
  end
end

