//
//  ImageAssembler.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

protocol ImageAssemblerProtocol: AnyObject {
    func convertToImage(from data: Data) -> UIImage?
}

class ImageAssembler: ImageAssemblerProtocol {
    func convertToImage(from data: Data) -> UIImage? {
        if let image = UIImage(data: data) {
            return image
        } else {
            return nil
        }
    }
}
