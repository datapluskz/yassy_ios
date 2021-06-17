//
//  UIButton.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 24.02.2021.
//

import UIKit

extension UIButton {
    @discardableResult
    func configureButton(title: String, titleColor: UIColor, isEnabled: Bool, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: CGColor, height: CGFloat,backgroundColor: UIColor) -> UIButton{
        let button = UIButton(type: .system)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.isEnabled = isEnabled
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.backgroundColor = backgroundColor
        return button
    }
    
    func buttonRightImage(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 35)
        self.contentHorizontalAlignment = .right
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func buttonLeftImage(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 110, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func buttonLeftImages(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func buttonLeftImageee(image: UIImage, renderMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func moveImageLeftTextCenter(image : UIImage, imagePadding: CGFloat, renderingMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderingMode), for: .normal)
        guard let imageViewWidth = self.imageView?.frame.width else{return}
        guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
        self.contentHorizontalAlignment = .left
        let imageLeft = imagePadding - imageViewWidth / 2
        let titleLeft = (bounds.width - titleLabelWidth) / 2 - imageViewWidth
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imageLeft, bottom: 0.0, right: 0.0)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -titleLeft , bottom: 0.0, right: 0.0)
    }
    
    func buttonTitlePadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        titleEdgeInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
}

extension UIView {
    func shadowView() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 3
        self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        self.layer.shadowColor = #colorLiteral(red: 0.8913620459, green: 0.8913620459, blue: 0.8913620459, alpha: 1)
    }
    
    func hideShadowView() {
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    func setCellShadowTwo(){
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 3
        self.layer.masksToBounds = false
        self.clipsToBounds = false
    }
        
    func setInsideCellShadow(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 2
        self.layer.masksToBounds = false
        self.clipsToBounds = false
    }
}
