//
//  ImageLoader.swift
//  PartTimeJobs
//
//  Created by Alexander V. on 03.11.2023.
//

import Foundation

final class ImageLoader {
    
    static let instance = ImageLoader()
    private init() {}
    
    private let cache = NSCache<NSString, NSData>()
 
    func downloadImage(from urlString: String?, completed: @escaping (Data) -> Void) {
        guard let urlString else { return }

        let cacheKey = NSString(string: urlString)
        
        if let data = cache.object(forKey: cacheKey) {
            completed(data as Data)
            return
        }

        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  error == nil
            else { return }
            self.cache.setObject(data as NSData, forKey: cacheKey)
            completed(data)
        }
        
        task.resume()
    }
}
