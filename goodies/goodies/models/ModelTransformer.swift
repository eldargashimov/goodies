//
//  ModelTransformer.swift
//  goodies
//
//  Created by Mac on 12/27/20.
//
import RealmSwift

final class ModelTransformer {
    
    static func transformToModelForDB (from recipe: DishParse.Recipe) -> Dish {
        
        let parser = Parser()
        
        let dish = Dish()
        
        dish.name = recipe.title
        
        dish.imageData = parser.getImage(for: "\(recipe.id)") { alert in
            print(alert.message ?? "Can not transform to DB model:(")
        }.pngData()
        
        dish.timeCooking = "\(recipe.cooking_time["hours"] ?? 0) ч. \(recipe.cooking_time["minutes"] ?? 0) мин."
        
        dish.dishDescription = recipe.description
        dish.ingredients = transformIngredient(from: recipe.ingredients)
        
        dish.nutrilion.append(transformNutrilion(from: recipe.nutrition))
        dish.portions = recipe.portions
        
        for i in 1...recipe.steps.count {
            dish.steps.append(transformSteps(from: recipe.steps["\(i)"]!, with: recipe.id))
        }
        
        dish.calories.append(transformCalories(from: recipe.calories))
        
        dish.id = recipe.id
        
        return dish
    }
    
    static func transformSteps(from step: DishParse.Recipe.Step, with id: Int) -> Step {
        let stepDB = Step()
        
        let parser = Parser()
        
        stepDB.stepDescription = step.description
        
        if let stepImage = step.img {
            stepDB.stepImageData = parser.getImage(for: "\(id)" + "/" + stepImage) { alert in
                print(alert.message ?? "Can not transform to DB model:(")
            }.pngData()
        } else {
            stepDB.stepImageData = UIImage(named: "turok")?.pngData()
        }
        return stepDB
    }
    
    static func transformIngredient(from ingredients: [String:String]) -> List<Ingredient> {
        let ingredientsDB = List<Ingredient>()
        for (name, quantity) in ingredients {
            let ingredient = Ingredient()
            ingredient.name = name
            ingredient.quantity = quantity
            ingredientsDB.append(ingredient)
        }
        return ingredientsDB
    }
    
    static func transformNutrilion(from recipeNutrilion: [String:String]) -> Nutrilion {
        let nutrilion = Nutrilion()
        nutrilion.proteins = recipeNutrilion["Белки"]!
        nutrilion.fats = recipeNutrilion["Жиры"]!
        nutrilion.carbohydrates = recipeNutrilion["Углеводы"]!
        return nutrilion
    }
    
    static func transformCalories(from recipeCalories: DishParse.Recipe.Calories) -> Calories {
        let calories = Calories()
        calories.percent = recipeCalories.percent
        calories.unit = recipeCalories.unit
        calories.value = recipeCalories.value
        return calories
    }
}
