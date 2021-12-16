//
//  EpicAPIImageController.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 14.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

struct EPICImageDisplayModel {
    var dates: [String]
    var date: String
    var selectedDate: String?
    var image: UIImage?
}

class EpicAPIImageController: UITableViewController {
    var viewModel: EPICImageViewModelProtocol?
    var displayModel = EPICImageDisplayModel(dates: [], date: "", selectedDate: nil, image: UIImage(named: "placeholder"))
    var dates: [AvailableDate] = []
    var selectedDate: AvailableDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        viewModel?.delegate = self
        viewModel?.viewLoaded()
        
        tableView.register(EPICImageCell.self, forCellReuseIdentifier: EPICImageCell.reuseIdentifier)
        tableView.register(EPICDatePickerCell.self, forCellReuseIdentifier: EPICDatePickerCell.reuseIdentifier)
    }
}

extension EpicAPIImageController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EPICImageCell.reuseIdentifier,
                                                           for: indexPath) as? EPICImageCell else { fatalError() }
            cell.epicImageView.image = displayModel.image
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EPICDatePickerCell.reuseIdentifier,
                                                           for: indexPath) as? EPICDatePickerCell else { fatalError() }
            cell.delegate = self
            cell.datePicker.delegate = self
            cell.datePicker.dataSource = self
            cell.dateTextField.text = displayModel.date
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension EpicAPIImageController: EPICImageViewModelDelegate {
    func startLoading() {
        //
    }
    
    func stopLoading() {
        //
    }
    
    func updateDisplayModel(_ displayModel: EPICImageDisplayModel) {
        self.displayModel = displayModel
        tableView.reloadData()
    }
}

extension EpicAPIImageController: EPICDatePickerCellDelegate {
    func doneButtonIsClicked() {
        viewModel?.doneButtonClicked(displayModel.selectedDate)
    }
}

extension EpicAPIImageController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return displayModel.dates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return displayModel.dates[row]
    }
}

extension EpicAPIImageController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        displayModel.selectedDate = displayModel.dates[row]
    }
}
