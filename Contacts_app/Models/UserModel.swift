//
//  UserModel.swift
//  Contacts_app
//
//  Created by Vlad Zinevich on 11.08.2021.
//

import UIKit


struct User: Hashable, Decodable {
    var fullname: String
    var imageString: String
    var firstCharacter: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
