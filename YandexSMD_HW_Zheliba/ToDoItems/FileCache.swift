//
//  FileCache.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 21.06.2024.
//

import Foundation

import Foundation

class FileCache {
    
    // Коллекция задач
    private(set) var items: [TodoItem] = []
    
    // Добавление задачи
    func addItem(_ item: TodoItem) {
        if !items.contains(where: { $0.id == item.id }) {
            items.append(item)
        }
    }
    
    // Удаление по id
    func removeItem(by id: String) {
        items.removeAll { $0.id == id }
    }
    
    // Сохранение всех задач в файл
    func save(to filename: String) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        
        let jsonArray = items.map { $0.json }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonArray, options: [])
            try data.write(to: fileURL)
        } catch {
            print("Failed to save items: \(error)")
        }
    }
    
    // Загрузка всех задач из файла
    func load(from filename: String) {
        let fileURL = getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            let data = try Data(contentsOf: fileURL)
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                items = jsonArray.compactMap { TodoItem.parse(json: $0) }
            }
        } catch {
            print("Failed to load items: \(error)")
        }
    }
    
    // Получение директории
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
