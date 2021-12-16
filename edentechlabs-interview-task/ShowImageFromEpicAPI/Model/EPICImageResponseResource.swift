//
//  EPICImageResponseResource.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 16.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct EPICImageResponseResource: Codable, Hashable {
    let id: String
    let caption: String
    let imageName: String
    let version: String
    let centroidCoordinates: LocationResponseResource
    let dscovrPosition: PositionResponseResource
    let lunarPosition: PositionResponseResource
    let sunPosition: PositionResponseResource
    let attitudeQuaternios: AttitudeResponseResource
    let date: String
    let coords: CoordinateResponseResource
}

extension EPICImageResponseResource {
    enum CodingKeys: String, CodingKey {
        case id = "identifier"
        case caption = "caption"
        case imageName = "image"
        case version = "version"
        case centroidCoordinates = "centroid_coordinates"
        case dscovrPosition = "dscovr_j2000_position"
        case lunarPosition = "lunar_j2000_position"
        case sunPosition = "sun_j2000_position"
        case attitudeQuaternios = "attitude_quaternions"
        case date = "date"
        case coords = "coords"
    }
}
