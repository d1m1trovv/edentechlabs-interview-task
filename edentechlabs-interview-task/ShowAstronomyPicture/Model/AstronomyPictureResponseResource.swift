//
//  AstronomyPictureResponseResource.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct AstronomyPictureResponseResource: Codable, Equatable {
    let resource: [String: String]
    let conceptTags: String
    let date: Date
    let title: String
    let url: String
    let explanation: String
    let concepts: [Int: String]
}
