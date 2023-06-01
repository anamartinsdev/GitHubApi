//
//  DetailViewController.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
import UIKit

final class DetailViewController: UIViewController, ActivityIndicatorPresenting {

    private lazy var contentView: DetailView = {
        let view = DetailView()
        view.delegate = self
        return view
    }()

    var viewModel: DetailViewModelProtocol?
    var uiState: UIState = .onboarding

    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUsers()
        self.title = viewModel?.getUsername()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8)
        ])
        
    }

    fileprivate func setupViewModel() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.updateLoadingStatus = {
            if viewModel.isLoading {
                self.showActivityIndicator()
            } else {
                self.hideActivityIndicator()
            }
        }

        viewModel.internetConnectionStatus = {
            DispatchQueue.main.async {
                self.uiState = .internetConnectionStatus
                
            }
        }

        viewModel.serverErrorStatus = {
            DispatchQueue.main.async {
                self.uiState = .serverErrorStatus
            }
        }
    }
    
    func loadUsers() {
        viewModel?.loadUserDetail(completion: { result in
            guard let user = result else {
                return
            }
            DispatchQueue.main.async {
                self.contentView.setup(user: user)
                self.viewDidLayoutSubviews()
            }
        })
    }
}

extension DetailViewController: DetailViewDelegate {
    func didTapRepositories() {
        viewModel?.didTapButton()
    }
}
