//
//  YandexSMD_HW_ZhelibaTests
//
//  Created by Egor Anoshin on 21.06.2024.
//

import XCTest
@testable import YandexSMD_HW_Zheliba

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
        XCTAssertNil(json?["importance"])
        XCTAssertNil(json?["deadline"])
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
        let createdDate = Date()
        let dateFormatter = ISO8601DateFormatter()
        let createdDateString = dateFormatter.string(from: createdDate)
        
        let todoItem = TodoItem(id: "1", text: "Test Task", importance: .normal, deadline: nil, isCompleted: false, createdDate: createdDate, modifiedDate: nil)

        let csv = todoItem.csv
        let components = csv.components(separatedBy: ",")
        
        // print("Components count: \(components.count)")
        
        XCTAssertEqual(components.count, 7) // всегда 7 компонентов
        XCTAssertEqual(components[0], todoItem.id)
        XCTAssertEqual(components[1], todoItem.text)
        XCTAssertEqual(components[2], todoItem.importance.rawValue)
        XCTAssertEqual(components[3], "false")
        XCTAssertEqual(components[4], createdDateString)
        XCTAssertEqual(components[5], "") // пустая строка у modifiedDate
        XCTAssertEqual(components[6], "") // пустая строка у deadline
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
        XCTAssertEqual(ISO8601DateFormatter().string(from: todoItem!.createdDate), createdDate)
    }
    
}

