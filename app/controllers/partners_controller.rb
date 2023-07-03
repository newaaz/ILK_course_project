class PartnersController < ApplicationController
  #before_action :authorize_partner!

  after_action  :verify_authorized

  def destroy
    @partner = Partner.find(params[:id])
    authorize @partner    
    @partner.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(@partner)
    flash[:warning] = "Аккаунт удалён"
    redirect_to root_url    
  end

  private

  def pundit_user
    current_partner
  end
end
