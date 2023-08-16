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
            showMain(login: User.logins[0].login ?? "Login")
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
    
    func showMain(login: String) {
        let vc = MainViewController.createObject()
        let viewModel = MainViewModel()
        viewModel.login = login
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.viewControllers.removeAll()
        navigationController.pushViewController(vc, animated: true)

    }
    
    func showDetail() {
        let vc = DetailViewController.createObject()
        let viewModel = DetailViewModel()
        viewModel.model = UserData.userData
        vc.coordinator = self
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
