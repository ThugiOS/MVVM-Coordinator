//
//  MainViewController.swift
//  MVVM+Coordinator
//
//  Created by Никитин Артем on 16.08.23.
//

import UIKit

class MainViewController: UIViewController, Storyboardable {
    
    @IBOutlet var mainLabel: UILabel!
    
    weak var coordinator: AppCoordinator?
    var viewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Main screen")
        mainLabel.text = "Hello \(viewModel?.login ?? "Login")"
    }
    
    @IBAction func aboutButtonPressed(_ sender: Any) {
        coordinator?.showDetail()
    }
}
