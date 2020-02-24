//
//  UIColor+Extension.swift
//  TinkoffMidProject
//
//  Created by Georgy Fesenko on 23/02/2020.
//  Copyright © 2020 TinkoffFintech. All rights reserved.
//

import UIKit

public extension UIColor {
    static let accentBlue = UIColor(hex: 0x528BFF)
    static let accentBlueHighlighted = UIColor(hex: 0x426FCC)
    static let dangerRed = UIColor(hex: 0xFF7777)
    static let dangerRedHighlighted = UIColor(hex: 0xCC5E5E)
    static let commonGray = UIColor(hex: 0xF0F0F0)
    static let commonGrayHighlighted = UIColor(hex: 0xD0D0D0)
    static let whiteText = UIColor(hex: 0xFFFFFF)
    static let blackText = UIColor(hex: 0x333333)
    static let greyText = UIColor(hex: 0x888888)
    static let disabledText = UIColor(hex: 0xAAAAAA)
    static let borderGrey = UIColor(hex: 0xECECEC)

    // PlainTextField
    static let plainPlaceholder = UIColor(hex: 0xBBBBBB)
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alpha: Int = 255) {
        assert(red >= 0 && red <= 255, "Invalid red value")
        assert(green >= 0 && green <= 255, "Invalid green value")
        assert(blue >= 0 && blue <= 255, "Invalid blue value")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0 )
    }

    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: (hex >> 0) & 0xFF,
            alpha: 255
        )
    }

    convenience init(hexa: Int) {
        self.init(
            red: (hexa >> 24) & 0xFF,
            green: (hexa >> 16) & 0xFF,
            blue: (hexa >> 8) & 0xFF,
            alpha: (hexa >> 0) & 0xFF
        )
    }
}
