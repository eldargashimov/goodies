
import UIKit

struct DishParse: Codable {
    
    struct Ids: Codable {
        
        var list: [String]
    }
    
    struct IdsSearch: Codable {
        
        var items: [String]
    }
    
    struct Recipe: Codable {
        
        let title: String
        let cooking_time: [String: Int] // ["minutes": Int, "hours": Int]
        let description: String
        let ingredients: [String:String] // ["name" : "quantity"]
        let nutrition: [String:String] // ["Белки" : "количество", "жиры" : "количество", "углеводы" : "количество"]
        let portions: Int
        
        struct Step: Codable {
            let description: String
            let img: String?
        }
        
        let steps: [String:Step]

        struct Calories: Codable {
            
            let percent: Int
            let unit: String
            let value: Int
        }
        
        let calories: Calories
        
        let id: Int
    }
}
