//
//  Endpoint.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nasa.gov"
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

extension Endpoint {
    static func astronomyPicture(apiKey: String, date: String, conceptTags: String) -> Endpoint {
        return Endpoint(path: "/planetary/apod",
                        queryItems: [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "date", value: date),
                URLQueryItem(name: "concept_tags", value: conceptTags)
            ])
    }
}

