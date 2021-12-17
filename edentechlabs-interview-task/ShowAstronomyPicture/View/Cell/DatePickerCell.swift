//
//  DatePickerCell.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 15.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

protocol DatePickerCellDelegate: AnyObject {
    func doneButtonIsClicked(_ date: Date?)
}

class DatePickerCell: UITableViewCell {
    static let reuseIdentifier = String(describing: DatePickerCell.self)
    
    weak var delegate: DatePickerCellDelegate?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = "Pick date: "
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
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        return datePicker
    }()
    
    lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureDatePicker()
        configureTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func setTitleLabelText(_ text: String) {
        titleLabel.text = text
    }
    
    @objc func doneButtonClicked(_ sender: UIBarButtonItem) {
        dateTextField.resignFirstResponder()
        delegate?.doneButtonIsClicked(datePicker.date)
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let minimumDate = dateFormatter.date(from: "1995-06-16")
        
        datePicker.minimumDate = minimumDate
        datePicker.maximumDate = Date()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneButtonClicked(_:)))
        
        toolbar.sizeToFit()
        toolbar.setItems([doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    private func configureTextField() {
        if let image = UIImage(named: "expand-arrow") {
            arrowImageView.image = image
            dateTextField.rightViewMode = .always
            dateTextField.rightView = arrowImageView
        }
    }
}

