class CartsController < ApplicationController
  #TODO check cart
  before_action :correct_cart, only: :show

  def show 
  end
  
  def destroy
  end

  private

  def correct_cart
    #redirect_to root_url unless params[:id].to_i == session[:cart_id].to_i
  end

end