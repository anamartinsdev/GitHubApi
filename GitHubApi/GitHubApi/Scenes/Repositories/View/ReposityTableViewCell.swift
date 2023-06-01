//
//  ReposityTableViewCell.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 31/05/23.
//

import Foundation
import UIKit

protocol ReposityTableViewCellDelegate: AnyObject {
    func didTapCell(user: Repository)
}

final class ReposityTableViewCell: UITableViewCell {
    
    weak var delegate: ReposityTableViewCellDelegate?
    static let identifier = "ReposityTableViewCell"

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelUrl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = .blue
        return label
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
        contentView.addSubview(label)
        contentView.addSubview(labelUrl)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            label.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            label.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
           
            labelUrl.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 2),
            labelUrl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            labelUrl.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            labelUrl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor , constant: -16)
        ])
    }
    
    func configure(with repository: Repository) {
        label.text = repository.description
        labelUrl.text = repository.language
    }
}
