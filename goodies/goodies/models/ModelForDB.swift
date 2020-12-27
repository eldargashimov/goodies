import RealmSwift
import UIKit

final class Step: Object {
    @objc dynamic var stepDescription: String?
    @objc dynamic var stepImageData: Data?
}

final class Calories: Object {
    var percent: NSNumber?
    @objc dynamic var unit: String?
    var value: NSNumber?
}

final class Dish: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var timeCooking: String? 
    @objc dynamic var dishDescription: String?
    var ingredients: [String : String]?
    var nutrilion: [String : String]?
    var portions: NSNumber?
    
    var steps: [String : Step]?
    
    var calories: Calories?
    
    // ниже - код для создания НЕПУСТОЙ базы данных
    
    let someDishes = ["Карбонара",
                      "Борщ",
                      "Ичпачмак",
                      "Ризотто с креветками",
                      "Британский завтрак",
                      "Неаполитанская пицца",
                      "Хинкали",
                      "Манты",
                      "Тататрский плов",
                      "Бурата с томатами и перцем",
                      "Фаршированный перец",
                      "Ленивые вареники",
                      "Цезарь с курицей",
                      "Брускетта со страчателлой",
                      "Поэлья",
                      "Блинчики с сулугуни и шпинатом",
                      "Глазунья",
                      "Шарлотка",
                      "Фаршированный индюк"]

    func saveDishesToDB () {

        let imageData = UIImage(named: "dish")?.pngData()

        for dish in someDishes {
            
            let newDish = Dish()
            newDish.name = dish
            newDish.imageData = imageData
            newDish.timeCooking = "\(Int.random(in: 10...90)) мин."
            StorageManager.saveDishToDB(newDish)
        }
    }
}

