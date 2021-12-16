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
