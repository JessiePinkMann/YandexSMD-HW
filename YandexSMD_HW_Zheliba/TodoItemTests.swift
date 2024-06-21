//
//  TodoItemTests.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 21.06.2024.
//

import Foundation
import XCTest
@testable import YourAppName

class TodoItemTests: XCTestCase {

    func testTodoItemInitialization() {
        let id = "1"
        let text = "Test Task"
        let importance: TodoItem.Importance = .normal
        let deadline = Date()
        let isCompleted = false
        let createdDate = Date()
        let modifiedDate = Date()

        let todoItem = TodoItem(id: id, text: text, importance: importance, deadline: deadline, isCompleted: isCompleted, createdDate: createdDate, modifiedDate: modifiedDate)

        XCTAssertEqual(todoItem.id, id)
        XCTAssertEqual(todoItem.text, text)
        XCTAssertEqual(todoItem.importance, importance)
        XCTAssertEqual(todoItem.deadline, deadline)
        XCTAssertEqual(todoItem.isCompleted, isCompleted)
        XCTAssertEqual(todoItem.createdDate, createdDate)
        XCTAssertEqual(todoItem.modifiedDate, modifiedDate)
    }

    func testTodoItemJSONSerialization() {
        let todoItem = TodoItem(id: "1", text: "Test Task", importance: .normal, deadline: nil, isCompleted: false, createdDate: Date(), modifiedDate: nil)

        let json = todoItem.json as? [String: Any]
        XCTAssertNotNil(json)
        XCTAssertEqual(json?["id"] as? String, todoItem.id)
        XCTAssertEqual(json?["text"] as? String, todoItem.text)
        XCTAssertEqual(json?["isCompleted"] as? Bool, todoItem.isCompleted)
        XCTAssertNotNil(json?["createdDate"])
        XCTAssertNil(json?["importance"]) // Importance should not be saved if it is normal
        XCTAssertNil(json?["deadline"]) // Deadline is nil so it should not be saved
    }

    func testTodoItemJSONParsing() {
        let json: [String: Any] = [
            "id": "1",
            "text": "Test Task",
            "isCompleted": false,
            "createdDate": Date().timeIntervalSince1970
        ]

        let todoItem = TodoItem.parse(json: json)
        XCTAssertNotNil(todoItem)
        XCTAssertEqual(todoItem?.id, "1")
        XCTAssertEqual(todoItem?.text, "Test Task")
        XCTAssertEqual(todoItem?.isCompleted, false)
    }

    func testTodoItemCSVSerialization() {
        let todoItem = TodoItem(id: "1", text: "Test Task", importance: .normal, deadline: nil, isCompleted: false, createdDate: Date(), modifiedDate: nil)

        let csv = todoItem.csv
        let components = csv.split(separator: ",").map { String($0) }
        XCTAssertEqual(components.count, 6)
        XCTAssertEqual(components[0], todoItem.id)
        XCTAssertEqual(components[1], todoItem.text)
        XCTAssertEqual(components[2], todoItem.importance.rawValue)
        XCTAssertEqual(components[3], "false")
    }

    func testTodoItemCSVParsing() {
        let createdDate = ISO8601DateFormatter().string(from: Date())
        let csv = "1,Test Task,обычная,false,\(createdDate),"
        
        let todoItem = TodoItem.parse(csv: csv)
        XCTAssertNotNil(todoItem)
        XCTAssertEqual(todoItem?.id, "1")
        XCTAssertEqual(todoItem?.text, "Test Task")
        XCTAssertEqual(todoItem?.importance, .normal)
        XCTAssertEqual(todoItem?.isCompleted, false)
    }
}
