//
//  DishModel.swift
//  goodies
//
//  Created by Mac on 11/3/20.
//

import RealmSwift

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
        
        struct Source: Codable {
            
            let steps_img: [String:String?]
            let title_img: String?
        }
        
        let source: Source
        
        struct Calories: Codable {
            
            let percent: Int
            let unit: String
            let value: Int
        }
        
        let calories: Calories
        
        let id: Int
    }
}

func getIdArray (count: Int) -> [String] {
    
    var idArray: [String] = []
    
    let group = DispatchGroup()

    guard let url = URL(string: "http://0.0.0.0:5000/\(count)") else { return idArray }
    
    group.enter()
    URLSession.shared.dataTask(with: url) { (data,response,error) in
    
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let data = data else { return }
        
        do {
            
            let Ids = try JSONDecoder().decode(DishParse.Ids.self, from: data)
            idArray = Ids.list
        } catch {
//            let alert = UIAlertController(title: "Упс!", message: "Сервер недоступен:(", preferredStyle: .alert)
//            let action = UIAlertAction(title: "OK", style: .default)
//            alert.addAction(action)
            print(error.localizedDescription)
        }
        group.leave()
    }.resume()
    
    group.wait()
    return idArray
}



func getRecipes (count: Int)  -> [DishParse.Recipe] {
    
    var recepts: [DishParse.Recipe] = []
    
    let serverUrlString = "http://0.0.0.0:5000/"
    
    let idArray = getIdArray(count: count)
    
    let group = DispatchGroup()
    
        for id in idArray {
            
            let dishUrl = URL(string: "\(serverUrlString)recipe/\(id)")
            group.enter()
            URLSession.shared.dataTask(with: dishUrl!) { (data,response,error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let dataRecipe = data else { return }
                
                do {
                    
                    let newRecipe = try JSONDecoder().decode(DishParse.Recipe.self, from: dataRecipe)
                    recepts.append(newRecipe)
                } catch {
                    print(error.localizedDescription)
                }
                group.leave()
            }.resume()
            
        }
    group.wait()
    return recepts
}

func getImage(for key: String) -> UIImage {
    
    var image = UIImage()
    
    let group = DispatchGroup()

    let urlString = key.contains(".") ? "http://0.0.0.0:5000/step_img/\(key)" : "http://0.0.0.0:5000/title_img/\(key)"

    guard let url = URL(string: urlString) else {
        return image
    }
    
    group.enter()
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let imageData = data else {
            return
        }
        
        image = UIImage(data: imageData)!
        group.leave()
    }.resume()
    group.wait()
    return image
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
