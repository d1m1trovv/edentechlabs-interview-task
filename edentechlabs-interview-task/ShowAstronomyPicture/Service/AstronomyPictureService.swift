//
//  AstronomyPictureService.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol AstronomyPictureServiceProtocol: AnyObject {
    func getAstronomyPicture(date: String,
                             completion: @escaping (AstronomyPicture?, NetworkError?) -> Void)
}

class AstronomyPictureService: AstronomyPictureServiceProtocol {
    private let httpService: HTTPServiceProtocol
    private let astronomyPictureAssembler: AstronomyPictureAssemblerProtocol
    
    init(httpService: HTTPServiceProtocol = HTTPService(),
         astronomyPictureAssembler: AstronomyPictureAssemblerProtocol = AstronomyPictureAssembler()) {
        self.httpService = httpService
        self.astronomyPictureAssembler = astronomyPictureAssembler
    }
    
    func getAstronomyPicture(date: String,
                             completion: @escaping (AstronomyPicture?, NetworkError?) -> Void) {
        httpService.getAstronomyPicture(date: date) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result,
                error == nil {
                let astronomyPictureModel = self.astronomyPictureAssembler.convertToAstronomyPictureModel(from: result)
                completion(astronomyPictureModel, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
