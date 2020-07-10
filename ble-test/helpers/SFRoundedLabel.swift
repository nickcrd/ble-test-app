//
//  SFRoundedLabel.swift
//  ble-test
//
//  Created by nc on 10.07.20.
//  Copyright © 2020 NICKCONTROL Studios. All rights reserved.
//

//https://stackoverflow.com/a/60493688
import UIKit

@IBDesignable

class SFRoundedLabel: UILabel {

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setupFont()
    }

    override func prepareForInterfaceBuilder() {
        setupFont()
    }

    func setupFont() {
        self.font = self.font.asSFRounded()
    }
}

//https://stackoverflow.com/a/53818276/1343140
extension UIFont {
    var weight: UIFont.Weight {
        guard let weightNumber = traits[.weight] as? NSNumber else { return .regular }
        let weightRawValue = CGFloat(weightNumber.doubleValue)
        let weight = UIFont.Weight(rawValue: weightRawValue)
        return weight
    }

    private var traits: [UIFontDescriptor.TraitKey: Any] {
        return fontDescriptor.object(forKey: .traits) as? [UIFontDescriptor.TraitKey: Any]
            ?? [:]
    }

    func asSFRounded() -> UIFont {
        if #available(iOS 13.0, *) {
            let fontSize = self.pointSize
            let systemFont = UIFont.systemFont(ofSize: fontSize, weight: self.weight)

            let font: UIFont

            if let descriptor = systemFont.fontDescriptor.withDesign(.rounded) {
                font = UIFont(descriptor: descriptor, size: fontSize)
            } else {
                font = systemFont
            }

            return font
        } else {
            return self
        }
    }
}

extension NSMutableAttributedString {
    func setFontFace(font: UIFont, color: UIColor? = nil) {
        beginEditing()
        self.enumerateAttribute(
            .font,
            in: NSRange(location: 0, length: self.length)
        ) { (value, range, stop) in

            if let f = value as? UIFont,
              let newFontDescriptor = f.fontDescriptor
                .withFamily(font.familyName)
                .withSymbolicTraits(f.fontDescriptor.symbolicTraits) {

                let newFont = UIFont(
                    descriptor: newFontDescriptor,
                    size: font.pointSize
                )
                removeAttribute(.font, range: range)
                addAttribute(.font, value: newFont, range: range)
                if let color = color {
                    removeAttribute(
                        .foregroundColor,
                        range: range
                    )
                    addAttribute(
                        .foregroundColor,
                        value: color,
                        range: range
                    )
                }
            }
        }
        endEditing()
    }
}
