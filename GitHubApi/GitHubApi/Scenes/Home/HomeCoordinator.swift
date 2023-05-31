//
//  HomeCoordinator.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
import UIKit

protocol HomeCoordinatorProtocol {
    func navigateToNextController(user: User)
}

final class HomeCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = HomeViewController(viewModel: HomeViewModel(coordinator: self))
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    func navigateToNextController(user: User) {
        
    }
}
