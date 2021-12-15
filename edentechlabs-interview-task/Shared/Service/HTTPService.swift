//
//  HTTPService.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

class HTTPService {
    func getAstronomyPicture(date: Date,
                             completion: @escaping (AstronomyPictureResponseResource?, NetworkError?) -> Void) {
        let endpoint = Endpoint.astronomyPicture(apiKey: "he4ZKTcfjgpo2iOvgQpAAb5MoR8r3ZnGtoRHe8ds", date: "", conceptTags: "true")
        guard let url = endpoint.url else { return }
        
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
}
