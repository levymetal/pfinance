class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :load_category, only: :create

  load_and_authorize_resource

  # GET /categories
  # GET /categories.json
  def index
    @categories = current_user.categories.roots
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
    @categories = current_user.categories.where(ancestry: nil)
  end

  # GET /categories/1/edit
  def edit
    @categories = current_user.categories

    @entries_count = @category.entries.count
    @children_count = @category.children.count
  end

  # POST /categories
  # POST /categories.json
  def create
    # @category = Category.new(category_params)

    # if category_params['ancestry'] == '' 
      # category_params['name'] = 'cats'
    # end

    @category = current_user.categories.build(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        @categories = current_user.categories
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # https://github.com/ryanb/cancan/issues/835
    def load_category
      @category = Category.new(category_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :parent_id)
    end
end
