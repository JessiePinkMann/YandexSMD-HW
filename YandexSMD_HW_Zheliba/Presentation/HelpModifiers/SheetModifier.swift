//
//  SheetModifier.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 28.06.2024.
//

import Foundation
import SwiftUI

struct SheetModifier: ViewModifier {
    @ObservedObject var modalState: ModalState
    @ObservedObject var storage: StorageLogic
    func body(content: Content) -> some View {
        if UIDevice.current.userInterfaceIdiom != .pad {
            content
                .sheet(isPresented: $modalState.activateModalView, onDismiss: {
                    modalState.selectedItem = nil
                    modalState.didDismiss = true
                }) {
                    DetailsView(modalState: modalState)
                        .environmentObject(storage)
                }
        } else {
            content
        }
    }
}
