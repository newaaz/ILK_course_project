class Admin::TownsController < Admin::BaseController
  before_action :authorize_town!
  after_action  :verify_authorized

  def index
    @towns = Town.all    
  end
  
  def new
    @town = Town.new
  end

  def create
    @town = Town.new(town_params)    
    if @town.save        
      flash[:success] = "Town successfully created"
      redirect_to admin_towns_path
    else
      render :new, status: :unprocessable_entity
    end    
  end

  def edit
    @town = Town.find(params[:id])
  end

  def update
    @town = Town.find(params[:id])
    if @town.update(town_params)
      redirect_to admin_towns_path
      flash[:info] = 'Town successfully edited'
    else
      flash.now[:warning] = 'Failed to edit town'
      render :edit
    end
  end

  def destroy
    @town = Town.find(params[:id])
    @town.destroy
    flash[:info] = 'Town deleted'
    redirect_to admin_towns_path
  end

  private

  def town_params
    params.require(:town).permit(:name, :parent_name, :number, :avatar, :description)
  end

  def pundit_user
    current_owner
  end

  def authorize_town!
    authorize(@town || Town)
  end
end
