//
//  CustomPhoneTextField.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/10/21.
//

import UIKit

class CustomPhoneTextField: UITextField {
    
   
    let placeHolder : String
    init(placeHolder: String){
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(string: self.placeHolder, attributes: [
            .foregroundColor: UIColor.yassyLight,
            .font: UIFont.systemFont(ofSize: 24)
        ])
        self.font = .systemFont(ofSize: 24)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 16, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }

}
