//
//  EPICImageViewModel.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 16.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol EPICImageViewModelDelegate: AnyObject {
    func startLoading()
    func stopLoading()
    func updateDisplayModel(_ displayModel: EPICImageDisplayModel)
}

protocol EPICImageViewModelProtocol: AnyObject {
    func viewLoaded()
    func doneButtonClicked(_ date: String?)
    var delegate: EPICImageViewModelDelegate? { get set }
}

class EPICImageViewModel: EPICImageViewModelProtocol {
    private let epicImageService: EpicImageServiceProtocol
    private let dateAssembler: DateAssemblerProtocol
    private let imageLoader: ImageLoaderProtocol
    private let imageAssembler: ImageAssemblerProtocol
    
    weak var delegate: EPICImageViewModelDelegate?
    var displayModel = EPICImageDisplayModel(dates: [], date: "", selectedDate: nil, image: nil)
    
    init(epicImageService: EpicImageServiceProtocol = EpicImageService(),
         dateAssembler: DateAssemblerProtocol = DateAssembler(),
         imageLoader: ImageLoaderProtocol = ImageLoader(),
         imageAssembler: ImageAssemblerProtocol = ImageAssembler()) {
        self.epicImageService = epicImageService
        self.dateAssembler = dateAssembler
        self.imageLoader = imageLoader
        self.imageAssembler = imageAssembler
    }
    
    func viewLoaded() {
        loadAllAvailableDates()
    }
    
    func doneButtonClicked(_ date: String?) {
        startLoadingImageWithDate(date)
    }
    
    private func startLoadingImageWithDate(_ date: String?) {
        if let date = date {
            displayModel.selectedDate = date
            epicImageService.getImagesForGivenDate(date: date) { [weak self] result, error in
                guard let self = self else { return }
                if let result = result,
                    error == nil {
                    self.getImageForDate(result)
                }
            }
        }
    }
    
    private func getImageForDate(_ imageInformation: EPICImage) {
        let year = dateAssembler.getDateComponent(component: "year", from: imageInformation.date)
        let month = dateAssembler.getDateComponent(component: "month", from: imageInformation.date)
        let day = dateAssembler.getDateComponent(component: "day", from: imageInformation.date)
        
        displayModel.date = "\(year)-\(month)-\(day)"
        
        let requestResource = EPICImageRequestResource(year: year,
                                                       month: month,
                                                       day: day,
                                                       type: imageInformation.type,
                                                       imageName: imageInformation.name)
        
        imageLoader.loadEPICImage(requestResource: requestResource) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result,
                error == nil {
                let image = self.imageAssembler.convertToImage(from: result)
                self.displayModel.image = image
                self.delegate?.updateDisplayModel(self.displayModel)
            }
        }
    }
    
    private func loadAllAvailableDates() {
        delegate?.startLoading()
        epicImageService.getAllAvailableDates() { [weak self] result, error in
            guard let self = self else { return }
            if let result = result,
                error == nil {
                let uniqueDates = result.uniqued()
                let dates = uniqueDates.map() { "\($0.year)-\($0.month)-\($0.day)" }
                self.displayModel.dates = dates
                self.delegate?.updateDisplayModel(self.displayModel)
                self.startLoadingImageWithDate(dates[0])
            } 
        }
    }
}
