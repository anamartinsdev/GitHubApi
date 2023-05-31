//
//  ImageCacher.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
import UIKit

final class ImageCacher {
    private let cache: NSCache<NSString, UIImage>
    
    private init() {
        cache = NSCache<NSString, UIImage>()
    }
    
    static let shared = ImageCacher()
    
    func loadImage(for key: NSString) -> UIImage? {
        return cache.object(forKey: key)
    }
    
    func cache(image: UIImage, withKey key: NSString) {
        cache.setObject(image, forKey: key)
    }
}
