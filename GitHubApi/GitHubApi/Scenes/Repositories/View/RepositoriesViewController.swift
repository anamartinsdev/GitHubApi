//
//  RepositoriesViewController.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 31/05/23.
//

import Foundation
import UIKit

final class RepositoriesViewController: UIViewController, ActivityIndicatorPresenting {

    private let viewModel: RepositoriesViewModelProtocol
    var uiState: UIState = .onboarding

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.separatorStyle = .singleLine
        tableView.register(ReposityTableViewCell.self, forCellReuseIdentifier: ReposityTableViewCell  .identifier)
        return tableView
    }()
    
    init(viewModel: RepositoriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDelegate = self
        viewModel.loadRepositories()
        setupViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    fileprivate func setupViewModel() {
        viewModel.updateLoadingStatus = {
            if self.viewModel.isLoading {
                self.showActivityIndicator()
            } else {
                self.hideActivityIndicator()
            }
        }

        viewModel.internetConnectionStatus = {
            DispatchQueue.main.async {
                self.uiState = .internetConnectionStatus
                self.tableView.reloadData()
            }
        }

        viewModel.serverErrorStatus = {
            DispatchQueue.main.async {
                self.uiState = .serverErrorStatus
                self.tableView.reloadData()
            }
        }

        viewModel.didGetData = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReposityTableViewCell.identifier, for: indexPath) as? ReposityTableViewCell else {
            return UITableViewCell()
        }
        let model = viewModel.getRepositoryRow(indexPath: indexPath)
        cell.configure(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didOpenRepositoryURL(indexPath: indexPath)
    }
}

extension RepositoriesViewController: RepositoriesViewModelDelegate {
    func receivedData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
