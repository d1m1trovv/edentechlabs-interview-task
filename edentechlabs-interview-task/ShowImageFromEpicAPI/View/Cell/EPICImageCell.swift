//
//  EPICImageCell.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 16.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

class EPICImageCell: UITableViewCell {
    static let reuseIdentifier = String(describing: EPICImageCell.self)
    
    lazy var epicImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private func configureView() {
        contentView.layoutMargins = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        
        contentView.addSubview(epicImageView)
        
        let guide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            epicImageView.heightAnchor.constraint(equalToConstant: 250),
            epicImageView.topAnchor.constraint(equalTo: guide.topAnchor),
            epicImageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            epicImageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            epicImageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
            ])
    }
}
