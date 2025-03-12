//
//  MainCoordinator.swift
//  CodingTest
//
//  Created by Marco Gloria on 05/03/25.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = ViewController.instantiate()
        navigationController.pushViewController(vc, animated: false)
    }
}
