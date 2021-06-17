//
//  CustomLineTextField.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/30/21.
//

import UIKit

class CustomLineTextField: UITextField {

    let placeHolder : String
    init(placeHolder: String){
        self.placeHolder = placeHolder
        super.init(frame: .zero)
        self.attributedPlaceholder = NSAttributedString(string: self.placeHolder, attributes: [
            .foregroundColor: UIColor.yassyLight,
            .font: UIFont.systemFont(ofSize: 16)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTextField(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = Colors.yassySeperatorGray.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
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
