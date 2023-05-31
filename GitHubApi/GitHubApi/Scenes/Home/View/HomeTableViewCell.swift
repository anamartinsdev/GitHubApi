//
//  HomeTableViewCell.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    private var userCurrente: User?
    

    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.systemGray3.cgColor
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setupSubViews() {
        contentView.addSubview(loginLabel)
        contentView.addSubview(userImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.heightAnchor.constraint(equalToConstant: 50),
            userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
                       
            loginLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 8),
            loginLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with user: User) {
        self.userCurrente = user
        loginLabel.text = user.login
        userImageView.loadImage(fromString: user.avatarURL ?? "", withPlaceholder: #imageLiteral(resourceName: "github-logo"))
    }
}
