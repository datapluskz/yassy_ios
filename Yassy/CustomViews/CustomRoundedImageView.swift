//
//  CustomRoundedImageView.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import UIKit
import Kingfisher

class CustomRoundedImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Colors.yassySeperatorGray
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        self.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(from url: URL) {
        image = nil
        
        
        
        self.kf.setImage(with: url, placeholder: nil)
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        self.kf.indicatorType = .activity
    }
}
