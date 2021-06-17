//
//  CustomCircleImageView.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/21/21.
//

import UIKit
import Kingfisher

class CustomCircleImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
        self.layer.masksToBounds = true
        self.layer.cornerRadius = CGFloat(roundf(Float(self.frame.size.width / 2.0)))
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.yassyOrange.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(from url: URL) {
        image = nil
        
        self.kf.setImage(with: url)
        self.kf.indicatorType = .activity
    }
}
