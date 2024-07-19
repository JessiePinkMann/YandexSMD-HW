//
//  CalendarViewCoordinator.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 06.07.2024.
//

import UIKit
import Combine
import CocoaLumberjackSwift

@MainActor
class CalendarViewCoordinator: NSObject {
    var storage: StorageLogic
    var apiManager: DefaultNetworkingService
    var sections: [Date]
    var selectedItem = IndexPath(row: 0, section: 0)
    var isSelectedInCollectionView = false
    var view: CalendarView
    var modalState: ModalState
    var cancellables = Set<AnyCancellable>()
    
    init(storage: StorageLogic, modalState: ModalState, uiview: CalendarView, apiManager: DefaultNetworkingService) {
        self.apiManager = apiManager
        self.storage = storage
        self.sections = storage.getSections()
        self.view = uiview
        self.modalState = modalState
        super.init()
        storage.$isUpdated
            .sink { [weak self] value in
                guard let self = self else {
                    return
                }
                if value {
                    DispatchQueue.main.async {
                        self.sections = self.storage.getSections()
                        self.reloadData()
                        storage.isUpdated = false
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    @objc func plusButtonPressed() {
        modalState.changeValues(item: nil)
    }
    
    func updateData() {
        do {
            try storage.loadItemsFromJSON()
        } catch {
           DDLogError("\(#function): \(error.localizedDescription)")
        }
    }
    
    func reloadData() {
        view.collectionView.reloadData()
        view.tableView.reloadData()
    }
    
    func countNumberOfSections() -> Int {
        var anotherCategory = 0
        if !storage.getItemsForSection(section: sections.count).isEmpty {
            anotherCategory = 1
        }
        return storage.getItems().isEmpty ? 0 : sections.count + anotherCategory
    }
    
    func updateToDoItem(item: TodoItem) {
        storage.updateItem(item: item)
        storage.saveItemsToJSON()
        apiManager.incrementNumberOfTasks()
        updateToDoItemOnServer(item: item)
    }
    
    private func updateToDoItemOnServer(item: TodoItem, retryDelay: Int = Delay.minDelay) {
        Task {
            do {
                try await apiManager.updateTodoItem(item: item)
                storage.isUpdated = true
                apiManager.decrementNumberOfTasks()
                DDLogInfo("\(#function): the item have been updated successfully")
            } catch {
                DDLogError("\(#function): \(error.localizedDescription)")
                let error = error as? NetworkingErrors
                let isServerError = error?.localizedDescription == NetworkingErrors.serverError.localizedDescription
                if retryDelay < Delay.maxDelay, isServerError {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(retryDelay)) {
                        self.updateToDoItemOnServer(
                            item: item,
                            retryDelay: Delay.countNextDelay(from: retryDelay)
                        )
                    }
                } else {
                    storage.updateIsDirty(value: true)
                    apiManager.decrementNumberOfTasks()
                    storage.isUpdated = true
                }
            }
        }
    }
}
