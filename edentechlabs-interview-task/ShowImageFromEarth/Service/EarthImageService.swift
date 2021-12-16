//
//  EarthImageService.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 16.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol EarthImageServiceProtocol: AnyObject {
    func getImageForCurrentLocation(locationRequestResource: LocationRequestResource,
                                    completion: @escaping (EarthImage?, NetworkError?) -> Void)
}

class EarthImageService: EarthImageServiceProtocol {
    private let imageLoader: ImageLoaderProtocol
    private let earthImageAssembler: EarthImageAssemblerProtocol
    
    init(imageLoader: ImageLoaderProtocol = ImageLoader(),
         earthImageAssembler: EarthImageAssemblerProtocol = EarthImageAssembler()) {
        self.imageLoader = imageLoader
        self.earthImageAssembler = earthImageAssembler
    }
    
    func getImageForCurrentLocation(locationRequestResource: LocationRequestResource,
                                    completion: @escaping (EarthImage?, NetworkError?) -> Void) {
        imageLoader.loadImageForCurrentLocation(locationRequestResource: locationRequestResource) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result,
                error == nil {
                let earthImage = self.earthImageAssembler.convertToEarthImageModel(from: result)
                completion(earthImage, nil)
            } else {
                completion(nil, error)
            }
        }
    }
}
