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
        return AstronomyPicture(resource: astronomyPictureResponseResource.resource,
                                conceptTags: astronomyPictureResponseResource.conceptTags,
                                date: astronomyPictureResponseResource.date,
                                title: astronomyPictureResponseResource.title,
                                url: astronomyPictureResponseResource.url,
                                explanation: astronomyPictureResponseResource.explanation,
                                concepts: astronomyPictureResponseResource.concepts)
    }
}
