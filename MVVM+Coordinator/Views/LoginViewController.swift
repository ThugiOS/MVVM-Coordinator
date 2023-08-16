//
//  ViewController.swift
//  MVVM+Coordinator
//
//  Created by Никитин Артем on 14.08.23.
//

import UIKit

class LoginViewController: UIViewController, Storyboardable {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    var viewModel: LoginViewModel?
    var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) //#colorLiteral(
    }

    func bindViewModel() {
        viewModel!.statusText.bind({ (statusText) in
            DispatchQueue.main.async {
                self.label.text = statusText
            }
        })
        
        viewModel!.statusColor.bind({ (statusColor) in
            DispatchQueue.main.async {
                self.label.textColor = statusColor
            }
        })

    }

//TODO: переделать
    @IBAction func loginButtonPressed(_ sender: Any) {
        viewModel!.userButtonPressed(login: loginField.text ?? "!", password: passwordField.text ?? "!")
        if viewModel!.isLoggedIn {
            coordinator?.isLoggedIn = viewModel!.isLoggedIn
            coordinator?.showMain(login: loginField.text ?? "")
        }
    }
}


