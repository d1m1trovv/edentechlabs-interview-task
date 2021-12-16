//
//  EpicImageService.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 16.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol EpicImageServiceProtocol: AnyObject {
    func getAllAvailableDates(completion: @escaping ([AvailableDate]?, NetworkError?) -> Void)
    func getImagesForGivenDate(date: String, completion: @escaping (EPICImage?, NetworkError?) -> Void)
}

class EpicImageService: EpicImageServiceProtocol {
    private let httpService: HTTPServiceProtocol
    private let dateAssembler: DateAssemblerProtocol
    private let epicImageAssembler: EPICImageAssemblerProtocol
    
    init(httpService: HTTPServiceProtocol = HTTPService(),
         dateAssembler: DateAssemblerProtocol = DateAssembler(),
         epicImageAssembler: EPICImageAssemblerProtocol = EPICImageAssembler()) {
        self.httpService = httpService
        self.dateAssembler = dateAssembler
        self.epicImageAssembler = epicImageAssembler
    }
    
    func getAllAvailableDates(completion: @escaping ([AvailableDate]?, NetworkError?) -> Void) {
        httpService.getAllAvailableDates() { [weak self] result, error in
            guard let self = self else { return }
            if let result = result,
                error == nil {
                let availableDates = result.map() { self.dateAssembler.convertToDateModel(from: $0) }
                completion(availableDates, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    func getImagesForGivenDate(date: String, completion: @escaping (EPICImage?, NetworkError?) -> Void) {
        httpService.getImagesForGivenDate(date: date) { [weak self] result, error in
            guard let self = self else { return }
            if let result = result,
                error == nil {
                let mostRecentImage = self.getMostRecentImage(from: result)
                let mostRecentEPICImage = self.epicImageAssembler.convertToEPICImage(from: mostRecentImage)
                completion(mostRecentEPICImage, nil)
            } else {
                completion(nil, error)
            }
        }
    }
    
    private func getMostRecentImage(from: [EPICImageResponseResource]) -> EPICImageResponseResource {
        let sorted = from.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
        return sorted[0]
    }
}
