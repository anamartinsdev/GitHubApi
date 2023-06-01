//
//  HomeViewController.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
import UIKit

final class HomeViewController: UIViewController, ActivityIndicatorPresenting {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let tableView = UIRefreshControl()
        return tableView
    }()

    var viewModel: HomeViewModelProtocol?
    var uiState: UIState = .onboarding

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
        viewModel?.viewDelegate = self
        loadUsers()
        self.title = "GitHub"
    }

    override func viewDidLayoutSubviews() {
        setupUI()
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
    
    func loadUsers() {
        viewModel?.loadUsers()
        refreshControl.endRefreshing()
    }

    @objc private func refreshData(_ sender: Any) {
        loadUsers()
    }
}

extension HomeViewController {

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.separatorStyle = .singleLine
        tableView.separatorStyle = .none
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        refreshControl.isEnabled = false
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupViewLayout()
    }
    
    private func setupViewLayout() {
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeViewController: HomeViewModelViewDelegate {
    func receivedData() {
        DispatchQueue.main.async { [weak tableView] in
            tableView?.reloadData()
        }
    }
}
