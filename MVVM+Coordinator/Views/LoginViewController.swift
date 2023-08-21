//
//  ViewController.swift
//  MVVM+Coordinator
//
//  Created by Никитин Артем on 14.08.23.
//

import UIKit
import Combine

class LoginViewController: UIViewController, Storyboardable {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    var coordinator: AppCoordinator?
    var cancellabes = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }

    func bindViewModel() {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: loginField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.email, on: viewModel)
            .store(in: &cancellabes)
    
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: passwordField)
            .map { ($0.object as! UITextField).text ?? "" }
            .assign(to: \.password, on: viewModel)
            .store(in: &cancellabes)
        
        viewModel.isLoginEnabled
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &cancellabes)
        
        // привязываем подписчика
        viewModel.$state
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.loginButton.isEnabled = false
                    self?.loginButton.setTitle("Loading..", for: .normal)
                case .success:
                    self?.loginButton.setTitle("Login", for: .normal)
                case .failed:
                    self?.loginButton.setTitle("Login", for: .normal)
                case .none:
                    break
                }
            }
            .store(in: &cancellabes)
    }

//TODO: переделать
    @IBAction func loginButtonPressed(_ sender: Any) {
        viewModel.userButtonPressed()
        if viewModel.isLoggedIn {
            coordinator?.isLoggedIn = viewModel.isLoggedIn
            coordinator?.showMain(login: loginField.text ?? "")
        }
    }
}


