//
//  TodoItem.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 21.06.2024.
//

import Foundation

struct TodoItem {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let isCompleted: Bool
    let createdDate: Date
    let modifiedDate: Date?
    
    enum Importance: String {
        case low = "неважная"
        case normal = "обычная"
        case high = "важная"
    }
    
    init(id: String = UUID().uuidString, text: String, importance: Importance, deadline: Date? = nil, isCompleted: Bool = false, createdDate: Date = Date(), modifiedDate: Date? = nil) {
        self.id = id
        self.text = text
        self.importance = importance
        self.deadline = deadline
        self.isCompleted = isCompleted
        self.createdDate = createdDate
        self.modifiedDate = modifiedDate
    }
}

