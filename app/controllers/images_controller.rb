class ImagesController < ApplicationController
  # destroy image from ActiveStorage
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

  # destroy image from Carrierwave
  def destroy
    remove_image_at_index(params[:id].to_i)
    respond_to do |format|
      format.html {
        flash[:info] = "Изображение удалено"
        redirect_back fallback_location: root_path
      }
    
      format.turbo_stream do
        render turbo_stream:
          turbo_stream.remove("image_#{params[:id]}")
      end
    end
  end

  private

  def remove_image_at_index(index)
    listing_id = params[:listing].downcase + '_id'
    listing = params[:listing].constantize.find(params[listing_id])

    authorize listing, policy_class: ImagesPolicy

    listing.images.delete_at(index)
    listing.save
  end

  def pundit_user
    current_partner
  end
end

