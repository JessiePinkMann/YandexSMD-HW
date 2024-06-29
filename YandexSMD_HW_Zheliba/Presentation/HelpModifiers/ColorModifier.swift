//
//  ColorModifier.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 28.06.2024.
//

import Foundation
import SwiftUI

struct ColorModifier: ViewModifier {
    @Binding var todoItem: TodoItem
    func body(content: Content) -> some View {
        if todoItem.isDone {
            content
                .foregroundStyle(.gray)
                .strikethrough(color: .gray)
        }
        else {
            content
                .foregroundStyle(todoItem.color != nil ? Color(hex: todoItem.color!) : .primary)
                .strikethrough(false)
        }
    }
}
