//
//  Network.swift
//  goodies
//
//  Created by Mac on 12/13/20.
//

import Foundation
import UIKit

func getAlert(message : String) -> UIAlertController {
    let alert = UIAlertController(title: "Упс!", message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default)
    alert.addAction(action)
    return alert
}

final class Parser {
    
    static var internetConnectIsEnable: Bool = true
    
    func getIdArray (count: Int, completion: @escaping (UIAlertController) -> Void) -> [String] {
        
        var idArray: [String] = []
        let group = DispatchGroup()

        guard let url = URL(string: "http://0.0.0.0:5000/\(count)") else {
            completion(getAlert(message: "Не удалось загрузить данные с сервера:("))
            return idArray
        }
        
        group.enter()
        URLSession.shared.dataTask(with: url) { (data,response,error) in
        
            if let error = error {
                completion(getAlert(message: error.localizedDescription))
                return
            }
            guard let data = data else { return }
            do {
                let Ids = try JSONDecoder().decode(DishParse.Ids.self, from: data)
                idArray = Ids.list
            } catch {
                completion(getAlert(message: error.localizedDescription))
            }
            group.leave()
        }.resume()
        
        group.wait()
        return idArray
    }
    
    func getIdArrayForSearch(dishName: String, completion: @escaping (UIAlertController) -> Void) -> [String] {
        
        var idArray: [String] = []
        let group = DispatchGroup()
        let urlString = "http://0.0.0.0:5000/find/list/\(dishName)/1"
//        let resultStr = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        guard let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!) else {
            completion(getAlert(message: "Не удалось загрузить данные с сервера:("))
            return idArray
        }
        
//        if let url = URL(string: resultStr!) {
            group.enter()
            URLSession.shared.dataTask(with: url) { (data,response,error) in
            
                if let error = error {
                    completion(getAlert(message: error.localizedDescription))
                    return
                }
                guard let data = data else { return }
                do {
                    let ids = try JSONDecoder().decode(DishParse.IdsSearch.self, from: data)
                    idArray = ids.items
                    } catch {
                        completion(getAlert(message:error.localizedDescription))
                    }
                group.leave()
            }.resume()
            group.wait()
            return idArray
//        } else {
//            completion(getAlert(message: "Не удалось загрузить данные с сервера:("))
//            return idArray
//        }
    }

    func getRecipes (idArray: [String], completion: @escaping (UIAlertController) -> Void)  -> [DishParse.Recipe] {
        
        var recepts: [DishParse.Recipe] = []
        let serverUrlString = "http://0.0.0.0:5000/"
        let group = DispatchGroup()
            for id in idArray {
                let dishUrl = URL(string: "\(serverUrlString)recipe/\(id)")
                group.enter()
                URLSession.shared.dataTask(with: dishUrl!) { (data,response,error) in
                if let error = error {
                    completion(getAlert(message:error.localizedDescription))
                    return
                }
                guard let dataRecipe = data else { return }
                    do {
                        let newRecipe = try JSONDecoder().decode(DishParse.Recipe.self, from: dataRecipe)
                        recepts.append(newRecipe)
                    } catch {
                        completion(getAlert(message:error.localizedDescription))
                    }
                    group.leave()
                }.resume()
            }
        group.wait()
        return recepts
    }

 func getImage(for key: String, completion: @escaping (UIAlertController) -> Void) -> UIImage {
        
        var image = UIImage()
        let group = DispatchGroup()
        let urlString = key.contains(".") ? "http://0.0.0.0:5000/step_img/\(key)" : "http://0.0.0.0:5000/title_img/\(key)"

        guard let url = URL(string: urlString) else {
            completion(getAlert(message: "Не удалось загрузить данные с сервера:("))
            return image
        }
        group.enter()
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(getAlert(message:error.localizedDescription))
                return
            }
            if let imageData = data {
                image = UIImage(data: imageData) ?? UIImage(named: "turok")!
            } else {
                completion(getAlert(message:"Не удалось загрузить данные с сервера:("))
            }
            group.leave()
        }.resume()
        group.wait()
        return image
    }
}

