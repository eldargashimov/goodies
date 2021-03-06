import RealmSwift
import UIKit

class Dish: Object {
    
    @objc dynamic var name: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var timeCooking: String?
    
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
