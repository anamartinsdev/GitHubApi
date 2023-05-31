//
//  ActivityIndicatorPresenting.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
import UIKit

protocol ActivityIndicatorPresenting {
    func showActivityIndicator()
    func hideActivityIndicator()
}

extension ActivityIndicatorPresenting where Self: UIViewController {
    func showActivityIndicator() {
        guard !view.subviews.contains(where: { $0 is UIActivityIndicatorView }) else { return }
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .systemIndigo
        activityIndicator.center = CGPoint(x: view.center.x, y: (view.center.y - 80))
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            guard let activityIndicator = self.view.subviews.first(where: { $0 is UIActivityIndicatorView }) as? UIActivityIndicatorView else { return }
            activityIndicator.removeFromSuperview()
        }
    }
}
