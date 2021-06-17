//
//  CustomTextFieldWithImage.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 10.05.2021.
//

import UIKit

class CustomTextFieldWithImage: UITextField {

    init(placeHolder: String, imageName: String){
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [
            .foregroundColor: UIColor.yassyLight,
            .font: UIFont.systemFont(ofSize: 16)
        ])
        self.layer.cornerRadius = 8
        self.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: imageName)
        imageView.image = image
        leftView = imageView
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 28, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 28, dy: 0)
    }
    
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: 50)
    }


}
