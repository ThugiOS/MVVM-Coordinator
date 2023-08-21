//
//  User.swift
//  MVVM+Coordinator
//
//  Created by Никитин Артем on 14.08.23.
//

import Foundation

struct User {
    let login: String?
    let password: String?
}


extension User {
    static var logins = [
    User(login: "test@mail.com", password: "12345")
    ]
}
