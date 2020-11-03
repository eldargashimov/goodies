//
//  DishModel.swift
//  goodies
//
//  Created by Mac on 11/3/20.
//

import Foundation

struct Dish {
    
    var name: String
    var image: String
    var timeCooking: String?
    
    static let someDishes = ["Карбонара",
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
    
    static func generateDishes () -> [Dish] {
        var dishes = [Dish]()
        
        for dish in someDishes {
            dishes.append(Dish(name: dish, image: "dish", timeCooking: "15 мин."))
        }
        return dishes
    }
    
}
