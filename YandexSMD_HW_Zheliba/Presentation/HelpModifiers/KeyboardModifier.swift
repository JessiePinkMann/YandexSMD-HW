//
//  KeyboardModifier.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 06.07.2024.
//

import Foundation
import SwiftUI

struct KeyboardModifier: ViewModifier {
    @Binding var isHidden: Bool
    func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidShowNotification)) { _ in
                withAnimation {
                    isHidden = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardDidHideNotification)) { _ in
                withAnimation {
                    isHidden = false
                }
            }
    }
}
