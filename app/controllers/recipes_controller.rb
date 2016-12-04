class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  def index
    @recipes = Recipe.order( created_at: :desc )
  end

  # GET /recipes/new
  def new
    @recipe = current_user.recipes.new
    # @recipe = Recipe.new
  end

  # POST /recipes
  def create
    @recipe = current_user.recipes.new( recipe_params )
    # @recipe = Recipe.new recipe_params

    if @recipe.save
      redirect_to @recipe, notice: 'Recipe successfully created.'
    else
      render 'new'
    end
  end

  # GET /recipes/1
  def show
  end

  # GET /recipes/1/edit
  def edit
  end

  # PUT /recipes/1
  def update
    if @recipe.update( recipe_params )
      redirect_to @recipe, notice:'Recipe successfully updated.'
    else
      render 'edit'
    end
  end

  # DELETE /recipes/1
  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice:'Recipe successfully destroyed.'
  end

  private
    def set_recipe
      @recipe = Recipe.find params[:id]
    end

    def recipe_params
      params.require( :recipe ).permit( :title, :description, :image,
        ingredients_attributes: [:id, :name, :_destroy],
        directions_attributes: [:id, :step, :_destroy] )
    end
end
