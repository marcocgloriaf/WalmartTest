//
//  Coordinator.swift
//  CodingTest
//
//  Created by Marco Gloria on 05/03/25.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
