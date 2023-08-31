//
//  ViewModel.swift
//  MVVM+Coordinator
//
//  Created by Никитин Артем on 14.08.23.
//

import Foundation
import Combine

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
    }
        
    func isCorrectLogin() -> Bool {
        return email == "test@mail.com" && password == "12345"
    }
}
