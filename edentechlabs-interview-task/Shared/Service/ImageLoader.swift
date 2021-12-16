//
//  File.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol ImageLoaderProtocol: AnyObject {
    func loadImage(url: URL, completion: @escaping (Data?, NetworkError?) -> Void)
    func loadImageForCurrentLocation(locationRequestResource: LocationRequestResource,
                                     completion: @escaping (Data?, NetworkError?) -> Void)
}

class ImageLoader: ImageLoaderProtocol {
    func loadImage(url: URL, completion: @escaping (Data?, NetworkError?) -> Void) {
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
        }.resume()
    }
    
    func loadImageForCurrentLocation(locationRequestResource: LocationRequestResource,
                                     completion: @escaping (Data?, NetworkError?) -> Void) {
        let endpoint = Endpoint.imageFromEarth(longitude: locationRequestResource.longitude,
                                               latitude: locationRequestResource.latitude,
                                               date: locationRequestResource.date,
                                               apiKey: "he4ZKTcfjgpo2iOvgQpAAb5MoR8r3ZnGtoRHe8ds")
        guard let url = endpoint.url else { return }
        print(url)
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
        }.resume()
    }
}
