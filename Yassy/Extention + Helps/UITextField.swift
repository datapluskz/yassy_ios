//
//  UITextField.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 24.02.2021.
//

import UIKit

extension UITextField {
    
    func configureTextField(placeholder: String, cornerRadius: CGFloat, textColor: UIColor, font: String, fontSize: CGFloat,height: CGFloat,textAlignment: NSTextAlignment) {
        self.placeholder = placeholder
        self.layer.cornerRadius = cornerRadius
        self.textColor = textColor
        self.font = UIFont(name: font, size: fontSize)
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.textAlignment = textAlignment
    }
    
    func configureTextFieldBackground(backgroundColor: UIColor = .white, borderWidth: CGFloat = 0, borderColor: UIColor = .white, placeholderText: String = "", placeholderColor: UIColor = .white) {
        self.backgroundColor = backgroundColor
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
    }
    
    func configureCardTextField(backgroundColor: UIColor, placeholderText: String, placeholderColor: UIColor, textColor: UIColor)  {
        self.backgroundColor = backgroundColor
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                        attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
        self.textColor = textColor
    }
    
    func setupTextFieldShadow() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 3
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    func setupLeftImageToTextField(imageName: String) {
        self.leftViewMode = UITextField.ViewMode.always
        let imageView     = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image         = UIImage(named: imageName)
        imageView.image   = image
        leftView          = imageView
    }
    
    func setupLeftLabelToTextField(string: String, left: CGFloat) {
        self.leftViewMode = UITextField.ViewMode.always
        //let label         = UILabel(frame: CGRect(x: -20, y: -30, width: 50, height: 20))
        text        = string
       // leftView          = label
    }
    
    func setupBottomLine(color: UIColor, width: CGFloat) {
        let bottomLineSize = UIView()
        addSubview(bottomLineSize)
        bottomLineSize.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        bottomLineSize.backgroundColor = color
        bottomLineSize.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    
}

extension String {
func convertToInternationalFormat() -> String {
   let isMoreThanTenDigit = self.count > 10
   _ = self.startIndex
   var newstr = ""
   if isMoreThanTenDigit {
       newstr = "\(self.dropFirst(self.count - 10))"
   }
   else if self.count == 10{
       newstr = "\(self)"
   }
   else {
       return "number has only \(self.count) digits"
   }
   if  newstr.count == 10 {
       let internationalString = "(\(newstr.dropLast(7))) \(newstr.dropLast(4).dropFirst(3)) \(newstr.dropFirst(6).dropLast(2)) \(newstr.dropFirst(8))"
       newstr = internationalString
   }
   return newstr
}
}
