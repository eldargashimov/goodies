//
//  DishModel.swift
//  goodies
//
//  Created by Mac on 11/3/20.
//

import RealmSwift
import UIKit

struct DishParse: Codable {
    
    struct Ids: Codable {
        
        var list: [String]
    }
    
    struct Recipe: Codable {
        
        let title: String
        let cooking_time: [String: Int] // ["minutes": Int, "hours": Int]
        let description: String
        let ingredients: [String:String] // ["name" : "quantity"]
        let nutrition: [String:String] // ["Белки" : "количество", "жиры" : "количество", "углеводы" : "количество"]
        let portions: Int
        let steps: [String:[String:String?]] // ["номер шага": ["описание шага":"ключ к фото для шага"]]
        
//        struct Source: Codable {
//
//            let steps_img: [String:String?]
//            let title_img: String?
//        }
//
//        let source: Source
        
        struct Calories: Codable {
            
            let percent: Int
            let unit: String
            let value: Int
        }
        
        let calories: Calories
        
        let id: Int
    }
}

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
