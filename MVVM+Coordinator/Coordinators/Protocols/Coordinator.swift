//
//  Coordinator.swift
//  MVVM+Coordinator
//
//  Created by Никитин Артем on 15.08.23.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
