class AttachmentsController < ApplicationController
  def purge    
    attachment = ActiveStorage::Attachment.find(params[:id]) 
    authorize(attachment)   
    attachment.purge
    redirect_back fallback_location: root_path
  end

  private

  def pundit_user
    current_owner
  end
end
