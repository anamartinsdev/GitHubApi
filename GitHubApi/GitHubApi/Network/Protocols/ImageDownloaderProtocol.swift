//
//  ImageDownloaderProtocol.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
import UIKit

protocol ImageDownloaderProtocol {
    func loadImage(from url: URL, completion: @escaping ((UIImage?) -> Void))
}
