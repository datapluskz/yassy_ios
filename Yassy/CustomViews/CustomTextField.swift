//
//  CustomTextField.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 08.05.2021.
//

import UIKit

class CustomTextField: UITextField {
    
   
    let placeHolder : String
    init(placeHolder: String){
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(string: self.placeHolder, attributes: [
            .foregroundColor: UIColor.yassyLight,
            .font: UIFont.systemFont(ofSize: 16)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 4, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 4, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }

}
