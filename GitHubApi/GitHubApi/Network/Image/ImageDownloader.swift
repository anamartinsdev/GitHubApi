//
//  ImageDownloader.swift
//  GitHubApi
//
//  Created by Ana Carolina Martins Pessoa on 30/05/23.
//

import Foundation
import UIKit

final class ImageDownloader: ImageDownloaderProtocol {
    private let urlSession: URLSessionProtocol
    private let imageCache: ImageCacher
    
    init(urlSession: URLSessionProtocol = URLSession.shared, imageCache: ImageCacher = ImageCacher.shared) {
        self.urlSession = urlSession
        self.imageCache = imageCache
    }
    
    func loadImage(from url: URL, completion: @escaping ((UIImage?) -> Void)) {
        if let cachedImage = imageCache.loadImage(for: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
        } else {
            urlSession.dataTask(with: url) { [imageCache] (data, _, _) in
                guard
                    let data = data,
                    let image = UIImage(data: data)
                    else { return }
                imageCache.cache(image: image, withKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
    }
}

