//
//  Buttons.swift
//  DailyGo
//
//  Created by Danila Petrov on 26.03.2025.
//

import UIKit

extension Button {

    public enum Style {
        case interactiveElements
        case repetitionSelected
        case repetitionUnselected
        case menuSelected
        case menuUnselected
        case defaultStyle
    }
}

extension Button.Style {

    // MARK: - Public Properties

    var backgroundColor: UIColor {
        switch self {
        case .interactiveElements: return Colors.skyBlue
        case .repetitionSelected: return Colors.turquoise
        case .repetitionUnselected: return Colors.aquaMist
        case .menuSelected: return Colors.lavenderBlue
        case .menuUnselected: return Colors.periwinkle
        case .defaultStyle: return Colors.lavenderBlue
        }
    }

    var textFont: UIFont? {
        switch self {
        case .interactiveElements: return Fonts.anonymousPro_16
        case .repetitionSelected: return Fonts.anonymousPro_13
        case .repetitionUnselected: return Fonts.anonymousPro_13
        case .menuSelected: return Fonts.anonymousPro_13
        case .menuUnselected: return Fonts.anonymousPro_13
        case .defaultStyle: return Fonts.anonymousPro_24
        }
    }
}
