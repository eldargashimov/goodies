//
//  StorageManager.swift
//  goodies
//
//  Created by Mac on 11/9/20.
//

import RealmSwift

let realm = try! Realm()

final class StorageManager {
    
    static func saveDishToDB(_ dish: Dish) {
        
        try! realm.write {
            realm.add(dish)
        }
    }
    
    static func deleteDishFromDB(_ dish: Dish) {

        try! realm.write{
            realm.delete(dish)
        }
    }
}
