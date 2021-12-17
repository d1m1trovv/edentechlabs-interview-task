//
//  EPICImageAssembler.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 16.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol EPICImageAssemblerProtocol: AnyObject {
    func convertToEPICImage(from epicImageResponseResource: EPICImageResponseResource) -> EPICImage
}

class EPICImageAssembler: EPICImageAssemblerProtocol {
    func convertToEPICImage(from epicImageResponseResource: EPICImageResponseResource) -> EPICImage {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return EPICImage(name: epicImageResponseResource.imageName,
                         date: dateFormatter.date(from: epicImageResponseResource.date)!,
                         type: "jpg")
    }
}
