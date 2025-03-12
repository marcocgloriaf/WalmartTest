//
//  LaunchViewController.swift
//  CodingTest
//
//  Created by Marco Gloria on 07/03/25.
//

import UIKit
import Combine

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let navController = UINavigationController()
        let coordinator = CountryCoordinator(navigationController: navController)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: {
            coordinator.start()
        })
        
    }
}

