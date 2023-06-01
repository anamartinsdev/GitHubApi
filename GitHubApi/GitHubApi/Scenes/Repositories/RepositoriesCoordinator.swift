//
//  RepositoriesCoordinator.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 31/05/23.
//

import Foundation
import UIKit

protocol RepositoriesCoordinatorProtocol {
    func openRepository(with path: String)
}

final class RepositoriesCoordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var user: User?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewModel = RepositoriesViewModel(coordinator: self)
        viewModel.user = user
        let viewController = RepositoriesViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: false)
    }
}

extension RepositoriesCoordinator: RepositoriesCoordinatorProtocol {
    func openRepository(with path: String) {        guard let url = URL(string: path) else {
        return
    }
        UIApplication.shared.open(url)
    }
}
