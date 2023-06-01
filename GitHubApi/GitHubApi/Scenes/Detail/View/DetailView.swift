//
//  DetailView.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
import UIKit

protocol DetailViewDelegate: AnyObject {
    func didTapRepositories()
}

final class DetailView: UIView {

    weak var delegate: DetailViewDelegate?

    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2.0
        imageView.layer.borderColor = UIColor.systemGray3.cgColor
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var nameContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()

    private lazy var twitterLabel: UILabel = {
        let label = UILabel()
        label.text = "Twitter username: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var twitterContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()

    private lazy var userBioLabel: UILabel = {
        let label = UILabel()
        label.text = "Bio: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var userBioContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var companyLabel: UILabel = {
        let label = UILabel()
        label.text = "Company:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var companyContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Location: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var locationContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.text = "Followers: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var followersContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.text = "Following: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var followingContentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("REPOSITORIES", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 22
        button.addTarget(self, action: #selector(tapRepositories), for: .touchUpInside)
        return button
    }()

    required init(coder: NSCoder) {
        super.init(coder: coder)!
        commonInit()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        setupUI()
    }

    @objc private func tapRepositories() {
        delegate?.didTapRepositories()
    }

    func setup(user: UserDetail) {
        nameContentLabel.text = user.name ?? ""
        twitterContentLabel.text = user.twitterUsername ?? ""
        userBioContentLabel.text = user.bio ?? ""
        companyContentLabel.text = user.company ?? ""
        locationContentLabel.text = user.location ?? ""
        followersContentLabel.text = String(user.followers ?? 0)
        followingContentLabel.text = String(user.following ?? 0)
        userImageView.loadImage(fromString: user.avatarURL ?? "", withPlaceholder: #imageLiteral(resourceName: "github-logo"))
    }
}

private extension DetailView {
    func setupUI() {
        backgroundColor = .white
        addSubview(userImageView)
        addSubview(nameLabel)
        addSubview(nameContentLabel)
        addSubview(twitterLabel)
        addSubview(twitterContentLabel)
        addSubview(userBioLabel)
        addSubview(userBioContentLabel)
        addSubview(companyLabel)
        addSubview(companyContentLabel)
        addSubview(locationLabel)
        addSubview(locationContentLabel)
        addSubview(followersLabel)
        addSubview(followersContentLabel)
        addSubview(followingLabel)
        addSubview(followingContentLabel)
        addSubview(nextButton)
        setupViewLayout()
    }

    func setupViewLayout() {
         NSLayoutConstraint.activate([
             userImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
             userImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
             userImageView.heightAnchor.constraint(equalToConstant: 150),
             userImageView.widthAnchor.constraint(equalTo: userImageView.heightAnchor),
             
             nameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
             nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
             nameContentLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
             nameContentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),

             twitterLabel.topAnchor.constraint(equalTo: nameContentLabel.bottomAnchor, constant: 8),
             twitterLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
             twitterContentLabel.topAnchor.constraint(equalTo: twitterLabel.bottomAnchor, constant: 8),
             twitterContentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
             
             userBioLabel.topAnchor.constraint(equalTo: twitterContentLabel.bottomAnchor, constant: 10),
             userBioLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
             userBioContentLabel.topAnchor.constraint(equalTo: userBioLabel.bottomAnchor, constant: 8),
             userBioContentLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
             userBioContentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),

             companyLabel.topAnchor.constraint(equalTo: userBioContentLabel.bottomAnchor, constant: 8),
             companyLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
             companyContentLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 16),
             companyContentLabel.rightAnchor.constraint(equalTo: leftAnchor, constant: -50),

             locationLabel.topAnchor.constraint(equalTo: companyContentLabel.bottomAnchor, constant: 10),
             locationLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
             locationContentLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
             locationContentLabel.rightAnchor.constraint(equalTo: leftAnchor, constant: -50),

             followersLabel.topAnchor.constraint(equalTo: locationContentLabel.bottomAnchor, constant: 8),
             followersLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
             followersContentLabel.topAnchor.constraint(equalTo: followersLabel.bottomAnchor, constant: 16),
             followersContentLabel.rightAnchor.constraint(equalTo: leftAnchor, constant: -50),

             followingLabel.topAnchor.constraint(equalTo: followersContentLabel.bottomAnchor, constant: 10),
             followingLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
             followingContentLabel.topAnchor.constraint(equalTo: followingLabel.bottomAnchor, constant: 16),
             followingContentLabel.rightAnchor.constraint(equalTo: leftAnchor, constant: -50),

             nextButton.heightAnchor.constraint(equalToConstant: 48),
             nextButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
             nextButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
             nextButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
         ])
    }
}
