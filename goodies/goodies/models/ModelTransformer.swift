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
        dish.ingredients = recipe.ingredients
        dish.nutrilion = recipe.nutrition
        dish.portions = recipe.portions as NSNumber
        for (number,step) in recipe.steps {
            dish.steps?[number] = transformSteps(from: step)
        }
        
        dish.calories?.percent = recipe.calories.percent as NSNumber
        dish.calories?.unit = recipe.calories.unit
        dish.calories?.value = recipe.calories.value as NSNumber
        
        return dish
    }
    
//    static func transformForModelForNetwork (from dish: Dish) -> DishParse.Recipe {
//        
//        let recipe: DishParse.Recipe
//        
//        recipe.title = dish.name!
//        recipe.cooking_time
//        
//        return recipe
//    }
    
    static func transformSteps(from step: DishParse.Recipe.Step) -> Step {
        let stepDB = Step()
        
        let parser = Parser()
        
        stepDB.stepDescription = step.description
        
        if let stepImage = step.img {
            stepDB.stepImageData = parser.getImage(for: "\(stepImage)") { alert in
                print(alert.message ?? "Can not transform to DB model:(")
            }.pngData()
        } else {
            stepDB.stepImageData = UIImage(named: "turok")?.pngData()
        }
        return stepDB
    }
}
