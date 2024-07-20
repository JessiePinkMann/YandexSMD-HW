//
//  UINavigationController.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 13.07.2024.
//

import Foundation
import UIKit

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(
            title: "Назад",
            style: .plain,
            target: nil,
            action: nil
        )
    }
}
