//
//  YandexSMD_HW_UITests.swift
//  YandexSMD_HW_ZhelibaTests
//
//  Created by Egor Anoshin on 19.07.2024.
//

import XCTest

final class YandexSMD_HW_UITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
