//
//  CalendarViewCoordinator.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 06.07.2024.
//

import Foundation
import UIKit
import Combine

class CalendarViewCoordinator: NSObject {
    var storage: StorageLogic
    var sections: [Date]
    var selectedItem = IndexPath(row: 0, section: 0)
    var view: CalendarView
    var isSelectedFromCollectionView = false
    var modalState: ModalState
    var cancellables = Set<AnyCancellable>()
    
    init(storage: StorageLogic, modalState: ModalState, uiview: CalendarView) {
        self.storage = storage
        self.sections = storage.getSections()
        self.view = uiview
        self.modalState = modalState
        super.init()
        storage.$isUpdated
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.sections = self.storage.getSections()
                self.reloadData()
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
           print(error)
        }
    }
    
    func reloadData() {
        view.collectionView.reloadData()
        view.tableView.reloadData()
    }
    
    func countNumberOfSections() -> Int {
        var anotherCategory = 0
        if storage.getItemsForSection(section: sections.count).count != 0 {
            anotherCategory = 1
        }
        return storage.getItems().count == 0 ? 0 : sections.count + anotherCategory
    }
}
