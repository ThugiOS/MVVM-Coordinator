//
//  ViewModel.swift
//  MVVM+Coordinator
//
//  Created by Никитин Артем on 14.08.23.
//

import Foundation
import UIKit.UIColor

class LoginViewModel {
    // Dynamic это пользовательский класс который занимается биндигом интерфейса и модели данных
    var statusText = Dynamic("")
    var statusColor = Dynamic(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    var isLoggedIn: Bool = false
    
    func userButtonPressed(login: String, password: String) {
        if login != User.logins[0].login || password != User.logins[0].password {
            statusText.value = "Log in failed."
            statusColor.value = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        } else {
            statusText.value = "You successfully logged in."
            statusColor.value = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
    }
}
