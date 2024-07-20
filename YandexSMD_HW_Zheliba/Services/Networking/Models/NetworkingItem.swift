//
//  NetworkingItem.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 19.07.2024.
//

import Foundation

struct NetworkingItem: Codable {
    let status: String
    let element: NetworkingElement
    let revision: Int?
    init(status: String = "ok", element: NetworkingElement, revision: Int? = nil) {
        self.status = status
        self.element = element
        self.revision = revision
    }
}
