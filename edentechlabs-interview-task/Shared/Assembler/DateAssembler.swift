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
    func convertToDateModel(from date: String) -> AvailableDate
    func getDateComponent(component: String, from date: Date) -> String
    func convertDateToUserFriendlyFormat(_ date: String) -> String
}

class DateAssembler: DateAssemblerProtocol {
    func convertToDateModel(from dateResponseResource: DateResponseResource) -> AvailableDate {
        let seperatedDate = dateResponseResource.date.components(separatedBy: "-")
        return AvailableDate(year: seperatedDate[0],
                             month: seperatedDate[1],
                             day: seperatedDate[2])
    }
    
    func convertToDateModel(from date: String) -> AvailableDate {
        let seperatedDate = date.components(separatedBy: "-")
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
    
    func convertDateToUserFriendlyFormat(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date = dateFormatter.date(from: date)
        if let date = date {
            dateFormatter.dateFormat = "MMM d, yyyy"
            let stringDate = dateFormatter.string(from: date)
            return stringDate
        }
        
        return ""
    }
}
