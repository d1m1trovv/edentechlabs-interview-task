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
    let date: Date
    let centroidCoordinates: LocationResponseResource
    let dscovrPosition: PositionResponseResource
    let lunarPosition: PositionResponseResource
    let sunPosition: PositionResponseResource
    let attitudeQuaternios: AttitudeResponseResource
    let coords: CoordinateResponseResource
}
