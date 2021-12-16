//
//  HTTPService.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol URLSessionProtocol: AnyObject {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}

protocol HTTPServiceProtocol: AnyObject {
    func getAstronomyPicture(date: String,
                             completion: @escaping (AstronomyPictureResponseResource?, NetworkError?) -> Void)
    func getAllAvailableDates(completion: @escaping ([DateResponseResource]?, NetworkError?) -> Void)
    func getImagesForGivenDate(date: String,
                               completion: @escaping ([EPICImageResponseResource]?, NetworkError?) -> Void)
}

class HTTPService: HTTPServiceProtocol {
    func getAstronomyPicture(date: String,
                             completion: @escaping (AstronomyPictureResponseResource?, NetworkError?) -> Void) {
        let endpoint = Endpoint.astronomyPicture(apiKey: "he4ZKTcfjgpo2iOvgQpAAb5MoR8r3ZnGtoRHe8ds", date: date, conceptTags: "True")
        guard let url = endpoint.url else { return }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode),
                error == nil {
                do {
                    let responseData = try JSONDecoder().decode(AstronomyPictureResponseResource.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseData, nil)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(nil, .decodingError)
                    }
                    return
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, .connectionFailed)
                }
            }
        }.resume()
    }
    
    func getAllAvailableDates(completion: @escaping ([DateResponseResource]?, NetworkError?) -> Void) {
        let endpoint = Endpoint.allAvailableDates(apiKey: "he4ZKTcfjgpo2iOvgQpAAb5MoR8r3ZnGtoRHe8ds")
        guard let url = endpoint.url else { return }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode),
                error == nil {
                do {
                    let responseData = try JSONDecoder().decode([DateResponseResource].self, from: data)
                    DispatchQueue.main.async {
                        completion(responseData, nil)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(nil, .decodingError)
                    }
                    return
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, .connectionFailed)
                }
            }
        }.resume()
    }
    
    func getImagesForGivenDate(date: String,
                               completion: @escaping ([EPICImageResponseResource]?, NetworkError?) -> Void) {
        let endpoint = Endpoint.imageryForGivenDate(date: date, apiKey: "he4ZKTcfjgpo2iOvgQpAAb5MoR8r3ZnGtoRHe8ds")
        guard let url = endpoint.url else { return }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode),
                error == nil {
                do {
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                    let responseData = try JSONDecoder().decode([EPICImageResponseResource].self, from: data)
                    DispatchQueue.main.async {
                        completion(responseData, nil)
                    }
                } catch let error {
                    print(error.localizedDescription)
                    DispatchQueue.main.async {
                        completion(nil, .decodingError)
                    }
                    return
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil, .connectionFailed)
                }
            }
        }.resume()
    }
}
