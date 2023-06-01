//
//  DetailViewModel.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject {
    func receivedData()
}

protocol DetailViewModelProtocol: AnyObject {
    func loadUserDetail(completion: @escaping (UserDetail?) -> Void)
    func didTapButton()
    func getUsername() -> String
    var showAlertClosure: (() -> ())? { get set }
    var updateLoadingStatus: (() -> ())?  { get set }
    var internetConnectionStatus: (() -> ())?  { get set }
    var serverErrorStatus: (() -> ())?  { get set }
    var isLoading: Bool { get set }
    var delegate: DetailViewModelDelegate? { get set }
}

final class DetailViewModel {

    private let service: DetailServiceProtocol
    weak var delegate: DetailViewModelDelegate?
    var coordinator: DetailCoordinatorProtocol?
    var userDetail: UserDetail?
    var username: String = ""
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
    
    init(withHome serviceProtocol: DetailServiceProtocol = DetailService(client: NetworkCore()), coordinator: DetailCoordinatorProtocol) {
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

extension DetailViewModel: DetailViewModelProtocol {
    func loadUserDetail(completion: @escaping (UserDetail?) -> Void) {
        self.isLoading = true
        switch networkStatus {
        case .offline:
            self.isDisconnected = true
            self.isLoading = false
            self.internetConnectionStatus?()
            completion(nil)
        case .online:
            service.fetchUserDetail(username: user?.login ?? "") { [weak self] (result) in
                switch result {
                case let .success(user):
                    self?.isLoading = false
                    self?.userDetail = user
                    guard let userDetail = self?.userDetail else {
                        return
                    }
                    completion(userDetail)
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
                        completion(nil)
                    }
                }
            }
        default:
            self.isLoading = false
            completion(nil)
            break
        }
    }

    func didTapButton() {
        guard let user = user else {
            return
        }
        coordinator?.navigateToNextController(user: user)
    }

    func getUsername() -> String {
        return user?.login ?? ""
    }
}
