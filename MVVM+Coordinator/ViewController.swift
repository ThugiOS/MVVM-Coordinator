//
//  ViewController.swift
//  MVVM+Coordinator
//
//  Created by Никитин Артем on 14.08.23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var label: UILabel!
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) //#colorLiteral(
    }

    func bindViewModel() {
        viewModel.statusText.bind({ (statusText) in
            DispatchQueue.main.async {
                self.label.text = statusText
            }
        })
        
        viewModel.statusColor.bind({ (statusColor) in
            DispatchQueue.main.async {
                self.label.textColor = statusColor
            }
        })

    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        viewModel.userButtonPressed(login: loginField.text ?? "!", password: passwordField.text ?? "!")
    }
}


