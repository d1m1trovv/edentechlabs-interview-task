//
//  AstronomyPictureViewModel.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol AstronomyPictureViewModelDelegate: AnyObject {
    func startLoading()
    func stopLoading()
    func setCurrentDate(_ date: String?)
}

protocol AstronomyPictureViewModelProtocol: AnyObject {
    func viewLoaded()
    func doneButtonIsClicked(_ date: String?)
    var delegate: AstronomyPictureViewModelDelegate? { get set }
}

class AstronomyPictureViewModel: AstronomyPictureViewModelProtocol {
    private let astronomyPictureService: AstronomyPictureServiceProtocol
    
    weak var delegate: AstronomyPictureViewModelDelegate?
    
    init(astronomyPictureService: AstronomyPictureServiceProtocol = AstronomyPictureService()) {
        self.astronomyPictureService = astronomyPictureService
    }
    
    func viewLoaded() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        
        delegate?.setCurrentDate(currentDate)
    }
    
    func doneButtonIsClicked(_ date: String?) {
        //
    }
    
    private func loadAstronomyPictureData() {
        delegate?.startLoading()
        
    }
}
