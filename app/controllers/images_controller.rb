class ImagesController < ApplicationController
  def purge    
    image = ActiveStorage::Attachment.find(params[:id]) 
    authorize(image)   
    image.purge

    respond_to do |format|
      format.html {
        flash[:info] = "Изображение удалено"
        redirect_back fallback_location: root_path
      }
    
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.remove("attachment_#{image.id}")
      end
    end
  end

  private

  def pundit_user
    current_partner
  end
end

