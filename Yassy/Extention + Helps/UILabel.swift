//
//  UILabel.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 24.02.2021.
//

import UIKit

extension UILabel {
    func configureLabel(text: String, textColor: UIColor, textAlignment: NSTextAlignment, fontName: String, fontSize: CGFloat, numberOfLines: Int) {
        self.text = text
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = UIFont(name: fontName, size: fontSize)
        self.numberOfLines = numberOfLines
    }
    
    func configureStateLabel(textColor: UIColor, textAlignment: NSTextAlignment, fontName: String, fontSize: CGFloat, numberOfLines: Int) {
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.font = UIFont(name: fontName, size: fontSize)
        self.numberOfLines = numberOfLines
    }
}
