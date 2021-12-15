//
//  File.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

class ImageLoader {
    func load(url: URL, completion: @escaping (Data?, NetworkError?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode),
                error == nil {
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, .connectionFailed)
                }
            }
        }
    }
}
