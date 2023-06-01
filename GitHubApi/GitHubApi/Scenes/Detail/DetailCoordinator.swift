//
//  DetailCoordinator.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
import UIKit

protocol DetailCoordinatorProtocol {
    func navigateToNextController(user: User)
}

final class DetailCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var user: User?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = DetailViewModel(coordinator: self)
        viewModel.user = user
        let viewController = DetailViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension DetailCoordinator: DetailCoordinatorProtocol {
    func navigateToNextController(user: User) {
        let coord = RepositoriesCoordinator(navigationController: navigationController)
        coord.user = user
        coord.start()
    }
}
