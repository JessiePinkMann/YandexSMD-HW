//
//  DeadlineView.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 13.07.2024.
//

import Foundation
import SwiftUI

struct DeadlineView: View {
    @ObservedObject var viewModel: DetailsViewModel
    var body: some View {
        HStack {
            VStack(spacing: 0) {
                Text("Сделать до")
                    .frame(maxWidth: .infinity, alignment: .bottomLeading)
                    .foregroundStyle(Color(UIColor.label))
                if viewModel.showDate {
                    Text(viewModel.date.makePrettyString(dateFormat: "d MMMM yyyy"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.blue)
                        .font(.system(size: 13))
                        .gesture(
                            TapGesture().onEnded({
                                withAnimation {
                                    viewModel.showCalendar.toggle()
                                }
                            })
                        )
                }
            }
            .frame(height: 40)
            Toggle("", isOn: $viewModel.showDate)
        }
    }
}
