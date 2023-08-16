//
//  UserData.swift
//  MVVM+Coordinator
//
//  Created by Никитин Артем on 16.08.23.
//

import Foundation


struct UserData {
    var name: String?
    var city: String?
    var email: String?
    var phone: String?
}

extension UserData {
    static var userData = UserData(name: "Artem", city: "Minsk", email: "test@test.com", phone: "+3757776655")
}
