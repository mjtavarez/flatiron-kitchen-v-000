class Recipe < ActiveRecord::Base
    has_many :recipe_ingredients
    has_many :ingredients, through: :recipe_ingredients
    
    validates :name, presence: true
    
    accepts_nested_attributes_for :ingredients, reject_if: proc {|attributes| attributes['name'].blank?}
    
    def ingredients_attributes=(ingredients_attributes)
        ingredients_attributes.each do |i, ingredient_attributes|
            ingredient_attributes.values.each do |name|
                if name != ""
                    ingredient = Ingredient.find_or_create_by(ingredient_attributes)
                    self.ingredients << ingredient unless self.ingredients.include?(ingredient)
                end
            end
        end
    end
end
