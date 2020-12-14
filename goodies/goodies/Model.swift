//
//  Model.swift
//  goodies
//
//  Created by Karbyshev Maxim on 23/11/2020.
//

import Foundation

struct ShopItem:Codable {
    var name: String
    var isComplited: Bool
    var dose: String
    
    init(name: String, isComplited: Bool, dose: String) {
        self.name = name
        self.isComplited = isComplited
        self.dose = dose
    }
}

var ToShopItems: [ShopItem] = []

func moveItem(fromIndex: Int, toIndex: Int){
    let from = ToShopItems[fromIndex]
    ToShopItems.remove(at: fromIndex)
    ToShopItems.insert(from, at: toIndex)
    saveData()
}

func addItem(nameItem: String, isComplited: Bool = false, newDose: String) {
    ToShopItems.append(ShopItem(name: nameItem, isComplited: isComplited, dose: newDose))
    saveData()
}

func removeItem(at index: Int) {
    ToShopItems.remove(at: index)
    saveData()
}

func changeState(at item: Int) -> Bool {
    ToShopItems[item].isComplited = !(ToShopItems[item].isComplited)
    saveData()
    return ToShopItems[item].isComplited
}

func saveData() {
    UserDefaults.standard.set(try? PropertyListEncoder().encode(ToShopItems), forKey:"ToShopItems")
}

