//
//  Corr.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 16.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

struct CoordinateResponseResource: Codable, Hashable {
    let centroidCoordinates: LocationResponseResource
    let dscovrPosition: PositionResponseResource
    let lunarPosition: PositionResponseResource
    let sunPosition: PositionResponseResource
    let attitudeQuaternios: AttitudeResponseResource
}

extension CoordinateResponseResource {
    enum CodingKeys: String, CodingKey {
        case centroidCoordinates = "centroid_coordinates"
        case dscovrPosition = "dscovr_j2000_position"
        case lunarPosition = "lunar_j2000_position"
        case sunPosition = "sun_j2000_position"
        case attitudeQuaternios = "attitude_quaternions"
    }
}

