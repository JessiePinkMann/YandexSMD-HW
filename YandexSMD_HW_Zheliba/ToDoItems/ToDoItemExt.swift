//
//  ToDoItemExt.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 21.06.2024.
//

import Foundation

extension TodoItem {
    
    // Для парсинга json
    static func parse(json: Any) -> TodoItem? {
        guard let dictionary = json as? [String: Any] else { return nil }
        
        guard let id = dictionary["id"] as? String,
              let text = dictionary["text"] as? String,
              let createdDateTimestamp = dictionary["createdDate"] as? TimeInterval else {
            return nil
        }
        
        let importance: Importance
        if let importanceRaw = dictionary["importance"] as? String {
            importance = Importance(rawValue: importanceRaw) ?? .normal
        } else {
            importance = .normal
        }
        
        let deadline: Date?
        if let deadlineTimestamp = dictionary["deadline"] as? TimeInterval {
            deadline = Date(timeIntervalSince1970: deadlineTimestamp)
        } else {
            deadline = nil
        }
        
        let isCompleted = dictionary["isCompleted"] as? Bool ?? false
        let createdDate = Date(timeIntervalSince1970: createdDateTimestamp)
        
        let modifiedDate: Date?
        if let modifiedDateTimestamp = dictionary["modifiedDate"] as? TimeInterval {
            modifiedDate = Date(timeIntervalSince1970: modifiedDateTimestamp)
        } else {
            modifiedDate = nil
        }
        
        return TodoItem(id: id, text: text, importance: importance, deadline: deadline, isCompleted: isCompleted, createdDate: createdDate, modifiedDate: modifiedDate)
    }
    
    // Для формирования json
    var json: Any {
        var dictionary: [String: Any] = [
            "id": id,
            "text": text,
            "createdDate": createdDate.timeIntervalSince1970,
            "isCompleted": isCompleted
        ]
        
        if importance != .normal {
            dictionary["importance"] = importance.rawValue
        }
        
        if let deadline = deadline {
            dictionary["deadline"] = deadline.timeIntervalSince1970
        }
        
        if let modifiedDate = modifiedDate {
            dictionary["modifiedDate"] = modifiedDate.timeIntervalSince1970
        }
        
        return dictionary
    }
}

extension TodoItem {
    
    // Для CSV строки
    static func parse(csv: String) -> TodoItem? {
        let components = csv.split(separator: ",").map { String($0) }
        guard components.count >= 6 else { return nil }
        
        let id = components[0]
        let text = components[1]
        let importance = Importance(rawValue: components[2]) ?? .normal
        let isCompleted = components[3] == "true"
        
        let dateFormatter = ISO8601DateFormatter()
        
        let createdDate = dateFormatter.date(from: components[4]) ?? Date()
        let modifiedDate = components[5].isEmpty ? nil : dateFormatter.date(from: components[5])
        let deadline = components.count > 6 && !components[6].isEmpty ? dateFormatter.date(from: components[6]) : nil
        
        return TodoItem(id: id, text: text, importance: importance, deadline: deadline, isCompleted: isCompleted, createdDate: createdDate, modifiedDate: modifiedDate)
    }
    
    // Для формирования CSV строки
    var csv: String {
        var components: [String] = [
            id,
            text,
            importance.rawValue,
            isCompleted ? "true" : "false"
        ]
        
        let dateFormatter = ISO8601DateFormatter()
        components.append(dateFormatter.string(from: createdDate))
        components.append(modifiedDate != nil ? dateFormatter.string(from: modifiedDate!) : "")
        components.append(deadline != nil ? dateFormatter.string(from: deadline!) : "")
        
        return components.joined(separator: ",")
    }
}

