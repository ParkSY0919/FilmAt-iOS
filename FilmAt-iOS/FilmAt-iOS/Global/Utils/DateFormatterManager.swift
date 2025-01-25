//
//  DateFormatterManager.swift
//  FilmAt-iOS
//
//  Created by 박신영 on 1/25/25.
//


import Foundation

final class DateFormatterManager {
    
    static let shard = DateFormatterManager()
    
    private init() {}
    
    let dateFormatter = DateFormatter()
    
    func setDateString(strDate: String, format: String) -> String {
        let inputDate = DateFormatter()
        inputDate.dateFormat = "yyyy-MM-dd"
        let date = inputDate.date(from: strDate)
        
        let outputDate = DateFormatter()
        outputDate.dateFormat = format
        guard let date else {
            print("setDateString error")
            return ""
        }
        return outputDate.string(from: date)
    }
    
    func setDateStringFromDate(date: Date, format: String) -> String {
        let outputDate = DateFormatter()
        outputDate.dateFormat = format
        
        return outputDate.string(from: date)
    }
    
    func setDateStringFromString(date: String, format: String) -> Date {
        let outputDate = DateFormatter()
        outputDate.dateFormat = format
        
        return outputDate.date(from: date) ?? Date()
    }
    
    func setDateInChat(strDate: String) -> String {
        let inputDate = DateFormatter()
        //strDate 형식에 맞는 포맷 설정
        inputDate.dateFormat = "yyyy-MM-dd HH:mm"

        guard let date = inputDate.date(from: strDate) else {
            print("Invalid date format: \(strDate)")
            return "Invalid Date"
        }

        let outputDate = DateFormatter()
        //원하는 출력 형식 포맷 설정
        outputDate.dateFormat = "HH.mm a"
        outputDate.locale = Locale(identifier: "ko_KR")

        return outputDate.string(from: date)
    }
    
    func setTodayDate() -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        return outputFormatter.string(from: Date())
    }

    
}
