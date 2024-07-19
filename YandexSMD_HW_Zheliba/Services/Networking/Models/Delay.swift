//
//  Delay.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 19.07.2024.
//

import Foundation

struct Delay {
    static let minDelay = 2
    static let maxDelay = 120
    static let factor = 1.5
    static let jitter = 0.05
    static func countNextDelay(from delay: Int) -> Int {
        var nextDelay = min(Double(delay) * factor, Double(maxDelay))
        nextDelay += nextDelay * Double.random(in: 0 ... jitter)
        return Int(nextDelay)
    }
}
