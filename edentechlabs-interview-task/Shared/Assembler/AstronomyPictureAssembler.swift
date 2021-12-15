//
//  AstronomyPictureAssembler.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol AstronomyPictureAssemblerProtocol: AnyObject {
    func convertToAstronomyPictureModel(from astronomyPictureResponseResource: AstronomyPictureResponseResource) -> AstronomyPicture
}

class AstronomyPictureAssembler: AstronomyPictureAssemblerProtocol {
    func convertToAstronomyPictureModel(from astronomyPictureResponseResource: AstronomyPictureResponseResource) -> AstronomyPicture {
        return AstronomyPicture(copyright: astronomyPictureResponseResource.copyright,
                                media_type: astronomyPictureResponseResource.media_type,
                                date: astronomyPictureResponseResource.date,
                                title: astronomyPictureResponseResource.title,
                                url: astronomyPictureResponseResource.url,
                                explanation: astronomyPictureResponseResource.explanation,
                                hdurl: astronomyPictureResponseResource.hdurl,
                                service_version: astronomyPictureResponseResource.service_version)
    }
}
