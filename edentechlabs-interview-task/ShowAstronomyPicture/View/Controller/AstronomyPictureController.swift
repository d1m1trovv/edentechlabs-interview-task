//
//  AstronomyPictureController.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 14.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

struct AstronomyPictureDisplayModel {
    var image: UIImage?
    var title: String
    var date: String
}

protocol AstronomyPictureControllerDelegate: AnyObject {
    func setDateTextFieldText(_ text: String?)
}

class AstronomyPictureController: UITableViewController {
    private let imageAssembler = ImageAssembler()
    var viewModel: AstronomyPictureViewModel?
    
    var currentDate = Date()
    
    var displayModel = AstronomyPictureDisplayModel(image: UIImage(named: "placeholder"), title: "", date: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        viewModel?.delegate = self
        viewModel?.viewLoaded()
        
        tableView.register(AstronomyPictureCell.self, forCellReuseIdentifier: AstronomyPictureCell.reuseIdentifier)
        tableView.register(DatePickerCell.self, forCellReuseIdentifier: DatePickerCell.reuseIdentifier)
    }
}

extension AstronomyPictureController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AstronomyPictureCell.reuseIdentifier,
                                                           for: indexPath) as? AstronomyPictureCell else { fatalError() }
            cell.astronomyImageView.image = displayModel.image
            cell.setTitleLabelText(displayModel.title)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerCell.reuseIdentifier,
                                                           for: indexPath) as? DatePickerCell else { fatalError() }
            cell.delegate = self
            cell.dateTextField.text = displayModel.date
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension AstronomyPictureController: AstronomyPictureViewModelDelegate {
    func reloadData() {
        print(Thread.isMainThread)
        tableView.reloadData()
        print("Table reloaded")
    }
    
    func updateDisplayModel(_ displayModel: AstronomyPictureDisplayModel) {
        self.displayModel = displayModel
    }
    
    func startLoading() {
        //
    }
    
    func stopLoading() {
        //
    }
}

extension AstronomyPictureController: DatePickerCellDelegate {
    func doneButtonIsClicked(_ date: Date?) {
        viewModel?.doneButtonIsClicked(date)
    }
}
