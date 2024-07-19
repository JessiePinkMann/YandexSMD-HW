//
//  TextFieldFrameModifier.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 28.06.2024.
//

import Foundation
import SwiftUI

struct TextFieldFrameModifier: ViewModifier {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    func body(content: Content) -> some View {
        if verticalSizeClass == .compact || horizontalSizeClass == .regular {
            content
                .frame(minHeight: UIScreen.main.bounds.size.height * (4 / 5), alignment: .top)
        } else {
            content
                .frame(minHeight: 120, alignment: .top)
        }
    }
}
