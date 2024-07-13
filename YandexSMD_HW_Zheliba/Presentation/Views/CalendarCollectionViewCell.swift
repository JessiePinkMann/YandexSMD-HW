//
//  CalendarCollectionViewCell.swift
//  YandexSMD_HW_Zheliba
//
//  Created by Egor Anoshin on 06.07.2024.
//

import Foundation
import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    static let identifier = "CalendarCollectionViewCell"
    var stack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    override func prepareForReuse() {
        stack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        self.isSelected = false
    }
    func makeLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }
    func configureCell() {
        self.layer.cornerRadius = 16
        if self.isSelected {
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.gray.cgColor
            self.backgroundColor = .gray.withAlphaComponent(0.3)
        } else {
            usualCell()
        }
    }
    func usualCell() {
        self.backgroundColor = .clear
        self.layer.borderWidth = 0
    }
    func setupUI(day: String, month: String, isAnother: Bool = false) {
        self.addSubview(stack)
        let day = makeLabel(text: day)
        let month = makeLabel(text: month)
        [day, month].forEach {
            stack.addArrangedSubview($0)
        }
        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8)
        ])
        if isAnother {
            month.removeFromSuperview()
        }
        configureCell()
    }
}
