//
//  ProfileModel.swift
//  goodies
//
//  Created by Mac on 12/29/20.
//

import Foundation
import RealmSwift

final class Profile: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var surName: String = ""
    @objc dynamic var avatarImageData: Data? = nil
}
