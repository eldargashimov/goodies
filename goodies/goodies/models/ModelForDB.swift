import RealmSwift
import UIKit

final class Step: Object {
    @objc dynamic var stepDescription: String = ""
    @objc dynamic var stepImageData: Data? = nil
}

final class Calories: Object {
    @objc dynamic var percent = 0
    @objc dynamic var unit: String = ""
    @objc dynamic var value = 0
}

final class Ingredient: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var quantity: String = ""
}

final class Nutrilion: Object {
    @objc dynamic var proteins: String = ""
    @objc dynamic var fats: String = ""
    @objc dynamic var carbohydrates: String = ""
}

final class Dish: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var imageData: Data? = nil
    @objc dynamic var timeCooking: String = ""
    @objc dynamic var dishDescription: String = ""
    var ingredients = List<Ingredient>()
    let nutrilion = List<Nutrilion>() // 1
    @objc dynamic var portions = 0
    
    let steps = List<Step>()
    
    let calories = List<Calories>() // 1
    
    @objc dynamic var id = 0
}
