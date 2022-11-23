class CategoriesController<ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new    
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category successfully created"
      redirect_to categories_path
    else
      flash[:info] = "Категория не создана"
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])    
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path
      flash.now[:info] = 'Category successfully edited'
    else
      flash.now[:info] = 'Failed to edit category'
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:info] = 'Category deleted'
    redirect_to categories_path
  end

private

  def category_params
    params.require(:category).permit(:title, :number)
  end
end
