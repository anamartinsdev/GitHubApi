//
//  RepositoriesViewModel.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 31/05/23.
//

import Foundation

protocol RepositoriesViewModelDelegate: AnyObject {
    func receivedData()
}

protocol RepositoriesViewModelProtocol: AnyObject {
    func loadRepositories()
    func numberOfRows() -> Int
    func getRepositoryRow(indexPath: IndexPath) -> Repository
    func didOpenRepositoryURL(indexPath: IndexPath)
    var showAlertClosure: (() -> ())? { get set }
    var updateLoadingStatus: (() -> ())?  { get set }
    var internetConnectionStatus: (() -> ())?  { get set }
    var serverErrorStatus: (() -> ())?  { get set }
    var didGetData: (() -> ())?  { get set }
    var isLoading: Bool { get set }
    var viewDelegate: RepositoriesViewModelDelegate? { get set }
}

final class RepositoriesViewModel {
    
    private let service: RepositoriesServiceProtocol
    weak var viewDelegate: RepositoriesViewModelDelegate?
    var coordinator: RepositoriesCoordinatorProtocol?
    
    //var repositories: [Dictionary<String?, [Repository]>.Element] = [Dictionary<String?, [Repository]>.Element]()
    var repositories: [Repository] = [Repository]()

    var userDetail: UserDetail?
    var user: User?
    
    //MARK: -- Network checking
    
    /// Define networkStatus for check network connection
    var networkStatus = Reachability().connectionStatus()
    
    /// Define boolean for internet status, call when network disconnected
    var isDisconnected: Bool = false {
        didSet {
            self.alertMessage = "No network connection. Please connect to the internet"
            self.internetConnectionStatus?()
        }
    }
    
    //MARK: -- UI Status
    
    /// Update the loading status, use HUD or Activity Indicator UI
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    /// Showing alert message, use UIAlertController or other Library
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    //MARK: -- Closure Collection
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var internetConnectionStatus: (() -> ())?
    var serverErrorStatus: (() -> ())?
    var didGetData: (() -> ())?
    
    init(withHome serviceProtocol: RepositoriesServiceProtocol = RepositoriesService(client: NetworkCore()), coordinator: RepositoriesCoordinatorProtocol) {
        self.service = serviceProtocol
        self.coordinator = coordinator
        NotificationCenter.default.addObserver(self, selector: #selector(self.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: Reachability.ReachabilityStatusChangedNotification), object: nil)
        Reachability().monitorReachabilityChanges()
        
    }
    
    //MARK: Internet monitor status
    @objc func networkStatusChanged(_ notification: Notification) {
        self.networkStatus = Reachability().connectionStatus()
    }
}

extension RepositoriesViewModel: RepositoriesViewModelProtocol {
    func loadRepositories() {
        self.isLoading = true
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.isLoading = false
            self.internetConnectionStatus?()
        case .online:
            service.fetchUserRepositories(username: user?.login ?? "") { [weak self] (result) in
                switch result {
                case let .success(repositories):
                    self?.isLoading = false
                    self?.repositories = repositories
                    self?.didGetData?()
                case let .failure(error):
                    switch error {
                    case .urlNotFound,
                            .authenticationRequired,
                            .brokenData,
                            .couldNotFindHost,
                            .couldNotParseObject,
                            .badRequest,
                            .invalidHttpResponse,
                            .unknown:
                        self?.serverErrorStatus?()
                    }
                }
            }
        default:
            self.isLoading = false
            break
        }
    }

    func numberOfRows() -> Int {
        return repositories.count
    }
    
    func getRepositoryRow(indexPath: IndexPath) -> Repository {
        return repositories[indexPath.row]
    }

    func didOpenRepositoryURL(indexPath: IndexPath) {
        let repo = getRepositoryRow(indexPath: indexPath)
        let path = repo.htmlURL ?? ""
        coordinator?.openRepository(with: path)
    }
}
