//
//  Date+Ext.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 28.06.2024.
//

import Foundation

extension Date {
    private func makeFormatter(dateFormat: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "ru")
        return dateFormatter
    }
    
    func makePrettyString(dateFormat: String) -> String {
        return makeFormatter(dateFormat: dateFormat).string(from: self)
    }
    
    func isEqualDay(with anotherDate: Date?) -> Bool {
        guard let anotherDate = anotherDate else { return false }
        let calendar = Calendar.current
        let result = calendar.compare(self, to: anotherDate, toGranularity: .day)
        switch result {
        case .orderedSame:
            return true
        default:
            return false
        }
    }
}
