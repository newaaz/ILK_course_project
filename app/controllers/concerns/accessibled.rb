# from Devise Wiki: How to Setup Multiple Devise User Models
# https://github.com/heartcombo/devise/wiki/How-to-Setup-Multiple-Devise-User-Models

module Accessibled
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_owner
      flash.clear
      flash[:info] = 'You are owner (from Acessibled)'
      redirect_to(current_owner.admin? ? admin_root_path : owners_root_path) and return
    elsif current_customer
      flash.clear
      flash[:info] = 'You are customer (from Acessibled)'
      redirect_to customers_root_path and return
    end
  end
end
