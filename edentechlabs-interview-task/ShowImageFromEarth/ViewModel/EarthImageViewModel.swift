//
//  EarthImageViewModel.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 16.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import CoreLocation

protocol EarthImageViewModelDelegate: AnyObject {
    func startLoading()
    func stopLoading()
    func updateDisplayModel(_ displayModel: EarthImageDisplayModel)
}

protocol EarthImageViewModelProtocol: AnyObject {
    func viewLoaded()
    var delegate: EarthImageViewModelDelegate? { get set }
}

class EarthImageViewModel: NSObject, EarthImageViewModelProtocol {
    private let locationManager = CLLocationManager()
    private let earthImageService: EarthImageServiceProtocol
    private let imageAssembler: ImageAssemblerProtocol
    
    var requestResource = LocationRequestResource(longitude: "", latitude: "", date: "")
    var displayModel = EarthImageDisplayModel(image: nil)
    weak var delegate: EarthImageViewModelDelegate?
    
    init(earthImageService: EarthImageServiceProtocol = EarthImageService(),
         imageAssembler: ImageAssemblerProtocol = ImageAssembler()) {
        self.earthImageService = earthImageService
        self.imageAssembler = imageAssembler
    }
    
    func viewLoaded() {
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func configureRequestResource(coordinate: CLLocationCoordinate2D) {
        requestResource = LocationRequestResource(longitude: String(coordinate.longitude),
                                                  latitude: String(coordinate.latitude),
                                                  date: "2019-07-05")
        loadImageForCurrentLocation()
    }
    
    private func loadImageForCurrentLocation() {
        delegate?.startLoading()
        earthImageService.getImageForCurrentLocation(locationRequestResource: requestResource) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result,
                error == nil {
                let earthImage = self.imageAssembler.convertToImage(from: result.imageData)
                self.displayModel.image = earthImage
                self.delegate?.updateDisplayModel(self.displayModel)
            }
        }
    }
}

extension EarthImageViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        print(status)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            configureRequestResource(coordinate: location.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print(error)
    }
}
