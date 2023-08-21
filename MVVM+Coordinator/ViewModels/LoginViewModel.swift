//
//  ViewModel.swift
//  MVVM+Coordinator
//
//  Created by Никитин Артем on 14.08.23.
//

import Foundation
import Combine
//import UIKit.UIColor

enum ViewStates {
    case loading
    case success
    case failed
    case none
}

class LoginViewModel {
    
    var isLoggedIn: Bool = false
    
    @Published var email = ""
    @Published var password = ""
    @Published var state: ViewStates = .none
    
    var isValidEmailPublisher: AnyPublisher<Bool, Never> {
        $email
            .map { $0.isEmail() }
            .eraseToAnyPublisher()
    }
    
    var isValidPasswordPublisher: AnyPublisher<Bool, Never> {
        $password
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    var isLoginEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isValidEmailPublisher, isValidPasswordPublisher)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }
    
    // Проверка логина
    func userButtonPressed() {
        state = .loading
        
        if self.isCorrectLogin() {
            self.state = .success
            isLoggedIn = true
        } else {
            self.state = .failed
            isLoggedIn = false
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
//            guard let self = self else { return }
//            if self.isCorrectLogin() {
//                self.state = .success
//                isLoggedIn = true
//            } else {
//                self.state = .failed
//                isLoggedIn = false
//            }
//        }
//
        
        
        // сделаем проверку из сети
//        if login != User.logins[0].login || password != User.logins[0].password {
//            isLoggedIn = false
//        } else {
//            isLoggedIn = true
//        }
    }
    
//    func submitLogin() {
//        state = .loading
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
//            guard let self = self else { return }
//            if self.isCorrectLogin() {
//                self.state = .success
//            } else {
//                self.state = .failed
//            }
//        }
//    }
    
    func isCorrectLogin() -> Bool {
        return email == "test@mail.com" && password == "12345"
    }
    

}










// отправка запроса на сервер
//    func submitLogin() {
//        state = .loading
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
//            guard let self = self else { return }
//            if self.isCorrectLogin() {
//                state = .success
//            } else {
//                state = .failed
//            }
//        }
//    }

//    func isCorrectLogin() -> Bool {
//        return email == "test@mail.com" && password == "12345"
//    }







//class LoginViewModel {
//    // Dynamic это пользовательский класс который занимается биндигом интерфейса и модели данных
//    var statusText = Dynamic("")
//    var statusColor = Dynamic(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
//    var isLoggedIn: Bool = false
//
//    func userButtonPressed(login: String, password: String) {
//        if login != User.logins[0].login || password != User.logins[0].password {
//            statusText.value = "Log in failed."
//            statusColor.value = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
//            isLoggedIn = false
//        } else {
//            statusText.value = "You successfully logged in."
//            statusColor.value = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
//            isLoggedIn = true
//        }
//    }
//}
