module Accessibled
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected

  def check_user
    if current_partner
      flash.clear
      flash[:info] = 'You are partner (from Acessibled)'
      redirect_to partners_root_path and return
    elsif current_customer
      flash.clear
      flash[:info] = 'You are customer (from Acessibled)'
      redirect_to customers_root_path and return
    end
  end
end
