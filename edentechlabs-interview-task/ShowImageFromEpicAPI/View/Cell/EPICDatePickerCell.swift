//
//  EPICDatePickerCell.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 16.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

protocol EPICDatePickerCellDelegate: AnyObject {
    func doneButtonIsClicked()
}

class EPICDatePickerCell: UITableViewCell {
    static let reuseIdentifier = String(describing: EPICDatePickerCell.self)
    
    weak var delegate: EPICDatePickerCellDelegate?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = "Date: "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateTextField: TextField = {
        let textField = TextField()
        textField.layer.cornerRadius = 7.0
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.black.withAlphaComponent(0.5).cgColor
        textField.layer.masksToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        return toolbar
    }()
    
    lazy var datePicker: UIPickerView = {
        let datePicker = UIPickerView()
        return datePicker
    }()
    
    lazy var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureDatePicker()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setTitleLabelText(_ text: String) {
        titleLabel.text = text
    }
    
    @objc func doneButtonClicked(_ sender: UIBarButtonItem) {
        dateTextField.resignFirstResponder()
        delegate?.doneButtonIsClicked()
    }
    
    private func configureView() {
        contentView.layoutMargins = UIEdgeInsets(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0)
        
        stackView = UIStackView(arrangedSubviews: [titleLabel, dateTextField])
        stackView.axis = .vertical
        stackView.spacing = 3.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        let guide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: guide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
            ])
    }
    
    private func configureDatePicker() {        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneButtonClicked(_:)))
        
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
}
