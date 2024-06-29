//
//  CaseIterable.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 29.06.2024.
//

import Foundation

extension CaseIterable where Self: Equatable {
    func getIndex() -> Self.AllCases.Index {
        return Self.allCases.firstIndex(of: self)!
    }
}
