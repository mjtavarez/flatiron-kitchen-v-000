require 'pry'

class RecipesController < ApplicationController
  
  def new
    @recipe = Recipe.new
  end

  def edit
    set_recipe
  end

  def create
    @recipe = Recipe.create(recipe_params)
    # binding.pry
    redirect_to recipe_path(@recipe)
    # redirect_to @recipe
  end

  def show
    set_recipe
  end

  def update
    @recipe = Recipe.find(params[:id])
    
    if @recipe.update(recipe_params)
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
  
  private
  
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end
  
  def recipe_params
    params.require(:recipe).permit(:name, ingredients_attributes:[:name], ingredient_ids:[])
  end
end
