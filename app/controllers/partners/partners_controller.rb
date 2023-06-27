class PartnersController < ApplicationController


  def destroy    
    flash[:warning] = "Partner deleted"
    redirect_to root_url
    # destroy_resource
    # Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    # set_flash_message! :notice, :destroyed
    # yield resource if block_given?
    # respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end


  protected

  def destroy_resource
    resourse.destroy
  end


end
