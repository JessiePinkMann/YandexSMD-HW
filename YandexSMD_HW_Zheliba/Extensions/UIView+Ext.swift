//
//  UIView+Ext.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 06.07.2024.
//

import Foundation
import UIKit

extension UIView {
    func addShadow(height: Double, radius: CGFloat) {
        self.layer.shadowOffset = CGSize(width: 0.0, height: height)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = radius
    }
}
