//
//  AstronomyPictureController.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 14.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation
import UIKit

class AstronomyPictureController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DatePickerCell.reuseIdentifier,
                                                           for: indexPath) as? DatePickerCell else { fatalError() }
            return cell
        default:
            return UITableViewCell()
        }
    }
}
