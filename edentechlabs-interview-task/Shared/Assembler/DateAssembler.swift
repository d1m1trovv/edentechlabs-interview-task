//
//  DateAssembler.swift
//  edentechlabs-interview-task
//
//  Created by Admin on 16.12.21.
//  Copyright © 2021 Admin. All rights reserved.
//

import Foundation

protocol DateAssemblerProtocol: AnyObject {
    func convertToDateModel(from dateResponseResource: DateResponseResource) -> AvailableDate
}

class DateAssembler: DateAssemblerProtocol {
    func convertToDateModel(from dateResponseResource: DateResponseResource) -> AvailableDate {
        let seperatedDate = dateResponseResource.date.components(separatedBy: "-")
        return AvailableDate(year: seperatedDate[0],
                             month: seperatedDate[1],
                             day: seperatedDate[2])
    }
    
    func getDateComponent(component: String, from date: Date) -> String {
        let calendar = Calendar.current
        
        switch component {
        case "year":
            return String(calendar.component(.year, from: date))
        case "month":
            return String(calendar.component(.month, from: date))
        case "day":
            return String(calendar.component(.day, from: date))
        default:
            return ""
        }
    }
}
