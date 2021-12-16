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
}

protocol EPICImageViewModelProtocol: AnyObject {
    func viewLoaded()
    var delegate: EPICImageViewModelDelegate? { get set }
}

class EPICImageViewModel: EPICImageViewModelProtocol {
    weak var delegate: EPICImageViewModelDelegate?
    
    func viewLoaded() {
        <#code#>
    }
}
