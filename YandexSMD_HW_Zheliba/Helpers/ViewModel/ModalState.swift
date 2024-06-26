//
//  ModalState.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 28.06.2024.
//

import Foundation

final class ModalState: ObservableObject {
    @Published var activateModalView = false
    @Published var selectedItem: TodoItem?
    
    func changeValues(item: TodoItem?) {
        selectedItem = item
        activateModalView = true
    }
}
