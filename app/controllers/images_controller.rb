class ImagesController < ApplicationController
  def purge    
    image = ActiveStorage::Attachment.find(params[:id]) 
    authorize(image)   
    image.purge
    flash[:info] = "image deleted"
    redirect_back fallback_location: root_path
  end

  private

  def pundit_user
    current_partner
  end
end

