//
//  AppCoordinator.swift
//  MVVM+Coordinator
//
//  Created by Никитин Артем on 16.08.23.
//

import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    // залогинелся ли
    var isLoggedIn: Bool = false
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if isLoggedIn {
            // showMain()
        } else {
             showLogin()
        }
    }
    
    func showLogin() {
        let vc = LoginViewController.createObject()
        vc.coordinator = self
        vc.viewModel = LoginViewModel()
        vc.viewModel?.isLoggedIn = isLoggedIn
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
