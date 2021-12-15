//
//  TextField.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
