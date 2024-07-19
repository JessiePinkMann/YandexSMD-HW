//
//  MockTodoItems.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 19.07.2024.
//

import Foundation

class MockTodoItems {
    static let itemWithAllProperties = TodoItem(
        text: "5",
        importance: .important,
        deadline: Date(),
        isDone: false,
        changedAt: Date(),
        color: "#FFFFFF",
        category: Category(
            name: "Учеба",
            color: "#5F82FF"
        )
    )
    static let itemWithoutDeadline = TodoItem(
        text: "5",
        importance: .important,
        isDone: false,
        changedAt: Date(),
        color: "#FFFFFF",
        category: Category(
            name: "Учеба",
            color: "#5F82FF"
        )
    )
    static let itemWithoutColor = TodoItem(
        text: "5",
        importance: .important,
        deadline: Date(),
        isDone: false,
        changedAt: Date(),
        category: Category(
            name: "Учеба",
            color: "#5F82FF"
        )
    )
    static let itemWithoutCategoryColor = TodoItem(
        text: "5",
        importance: .important,
        deadline: Date(),
        isDone: false,
        changedAt: Date(),
        color: "#FFFFFF",
        category: Category(
            name: "Без категории",
            color: nil
        )
    )
    static let itemWithoutChangedAt = TodoItem(
        text: "5",
        importance: .important,
        deadline: Date(),
        isDone: false,
        color: "#FFFFFF",
        category: Category(
            name: "Учеба",
            color: "#5F82FF"
        )
    )
    static let itemWithBasicImportance = TodoItem(
        text: "5",
        importance: .basic,
        deadline: Date(),
        isDone: false,
        changedAt: Date(),
        color: "#FFFFFF",
        category: Category(
            name: "Учеба",
            color: "#5F82FF"
        )
    )
}
