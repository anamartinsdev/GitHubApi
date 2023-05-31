//
//  HomeViewModel.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

protocol HomeViewModelViewDelegate: AnyObject {
    func receivedData()
}

protocol HomeViewModelProtocol: AnyObject {
    func loadUsers()
    func numberOfRows() -> Int
    func getUserRow(indexPath: IndexPath) -> User
    func didTapCell(with user: User)
    var showAlertClosure: (() -> ())? { get set }
    var updateLoadingStatus: (() -> ())?  { get set }
    var internetConnectionStatus: (() -> ())?  { get set }
    var serverErrorStatus: (() -> ())?  { get set }
    var didGetData: (() -> ())?  { get set }
    var isLoading: Bool { get set }
    var viewDelegate: HomeViewModelViewDelegate? { get set }
}

final class HomeViewModel {
    
    private let service: HomeServiceProtocol
    weak var viewDelegate: HomeViewModelViewDelegate?
    var coordinator: HomeCoordinatorProtocol?
    
    var users: [User] = [User]() {
        didSet {
            self.count = self.users.count
            self.totalPages = self.users.count
        }
    }

    var user: UserDetail?

    /// Count your data in model
    var count: Int = 0
    /// Control page result
    var totalPages = 0
    var currentPage = 1
    
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
    
    init(withHome serviceProtocol: HomeServiceProtocol = HomeService(client: NetworkCore()), coordinator: HomeCoordinatorProtocol) {
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

extension HomeViewModel: HomeViewModelProtocol {
    func loadUsers() {
        self.isLoading = true
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.isLoading = false
            self.internetConnectionStatus?()
        case .online:
            service.fetchUsers { [weak self] (result) in
                switch result {
                case let .success(users):
                    self?.isLoading = false
                    self?.users = users
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
        return users.count
    }
    
    func getUserRow(indexPath: IndexPath) -> User {
        return users[indexPath.row]
    }

    func didTapCell(with user: User) {
        coordinator?.navigateToNextController(user: user)
    }
}

