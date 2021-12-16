//
//  EarthImageController.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 14.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

struct EarthImageDisplayModel {
    var image: UIImage?
}

class EarthImageController: UIViewController {
    private let imageView = EarthImageView()
    
    var displayModel = EarthImageDisplayModel(image: UIImage(named: "placeholder"))
    var viewModel: EarthImageViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewModel?.delegate = self
        viewModel?.viewLoaded()
        
        configureImageView()
    }
    
    private func configureImageView() {
        imageView.imageView.image = displayModel.image
        let guide = view.safeAreaLayoutGuide
        
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: guide.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
            ])
    }
    
    private func update() {
        imageView.setImage(displayModel.image)
    }
}

extension EarthImageController: EarthImageViewModelDelegate {
    func startLoading() {
        //
    }
    
    func stopLoading() {
        //
    }
    
    func updateDisplayModel(_ displayModel: EarthImageDisplayModel) {
        self.displayModel = displayModel
        update()
    }
}
