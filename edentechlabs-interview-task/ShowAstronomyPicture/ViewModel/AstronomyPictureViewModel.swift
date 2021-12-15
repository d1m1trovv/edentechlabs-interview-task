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
    func updateDisplayModel(_ displayModel: AstronomyPictureDisplayModel)
    func setCurrentDate(_ date: String?)
}

protocol AstronomyPictureViewModelProtocol: AnyObject {
    func viewLoaded()
    func cellIsBeingConfigured()
    func doneButtonIsClicked(_ date: Date?)
    var delegate: AstronomyPictureViewModelDelegate? { get set }
}

class AstronomyPictureViewModel: AstronomyPictureViewModelProtocol {
    private let astronomyPictureService: AstronomyPictureServiceProtocol
    private let imageLoader: ImageLoaderProtocol
    private let imageAssembler: ImageAssemblerProtocol
    
    weak var delegate: AstronomyPictureViewModelDelegate?
    var astronomyPictureModel: AstronomyPicture?
    
    var astronomyPictureDisplayModel = AstronomyPictureDisplayModel(image: nil, title: "")
    
    init(astronomyPictureService: AstronomyPictureServiceProtocol = AstronomyPictureService(),
         imageLoader: ImageLoaderProtocol = ImageLoader(),
         imageAssembler: ImageAssemblerProtocol = ImageAssembler()) {
        self.astronomyPictureService = astronomyPictureService
        self.imageLoader = imageLoader
        self.imageAssembler = imageAssembler
    }
    
    func viewLoaded() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        
        delegate?.setCurrentDate(currentDate)
        loadAstronomyPictureData(Date())
    }
    
    func doneButtonIsClicked(_ date: Date?) {
        if let date = date {
            loadAstronomyPictureData(date)
        }
    }
    
    func cellIsBeingConfigured() {
       //
    }
    
    private func loadAstronomyPictureData(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        
        astronomyPictureService.getAstronomyPicture(date: formattedDate) { [weak self] result, error in
            guard let self = self else { return }
            self.delegate?.startLoading()
            if let result = result,
                error == nil {
                self.astronomyPictureModel = result
                if let astronomyPictureModel = self.astronomyPictureModel {
                    self.astronomyPictureDisplayModel.title = astronomyPictureModel.title
                    self.delegate?.updateDisplayModel(self.astronomyPictureDisplayModel)
                }
                self.loadImage(urlString: self.astronomyPictureModel?.url)
            }
        }
    }
    
    private func loadImage(urlString: String?) {
        if let urlString = urlString {
            guard let url = URL(string: urlString) else { return }
            imageLoader.load(url: url) { [weak self] data, error in
                guard let self = self else { return }
                if let data = data,
                    error == nil {
                    if let image = self.imageAssembler.convertToImage(from: data) {
                        self.astronomyPictureDisplayModel.image = image
                    }
                    self.delegate?.updateDisplayModel(self.astronomyPictureDisplayModel)
                }
            }
        }
    }
}
