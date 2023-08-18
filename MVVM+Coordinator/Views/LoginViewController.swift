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
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    
    var viewModel = LoginViewModel()
    var coordinator: AppCoordinator?
    var cancellabes = Set<AnyCancellable>()
    
    func initialState() {
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) //#colorLiteral(
        label.isHidden = true
        label.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        initialState()
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
                            self?.label.isHidden = true
                            self?.loginButton.isEnabled = false
                            self?.loginButton.setTitle("Loading..", for: .normal)
                        case .success:
                            self?.label.isHidden = false
                            self?.label.text = "Login success!"
                            self?.label.textColor = .systemGreen
                            self?.loginButton.setTitle("Login", for: .normal)
                        case .failed:
                            self?.label.isHidden = false
                            self?.label.text = "Login failed =("
                            self?.label.textColor = .systemRed
                            self?.loginButton.setTitle("Login", for: .normal)
                        case .none:
                            break
                        }
                    }
                    .store(in: &cancellabes)
        
        
//        viewModel!.statusText.bind({ (statusText) in
//            DispatchQueue.main.async {
//                self.label.text = statusText
//            }
//        })
//
//        viewModel!.statusColor.bind({ (statusColor) in
//            DispatchQueue.main.async {
//                self.label.textColor = statusColor
//            }
//        })
    }

//TODO: переделать
    @IBAction func loginButtonPressed(_ sender: Any) {
        viewModel.submitLogin()
        
        
//        viewModel!.userButtonPressed(login: loginField.text ?? "!", password: passwordField.text ?? "!")
//        if viewModel!.isLoggedIn {
//            coordinator?.isLoggedIn = viewModel!.isLoggedIn
//            coordinator?.showMain(login: loginField.text ?? "")
//        }
    }
}


