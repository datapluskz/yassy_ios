//
//  InfoLogoCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import UIKit

class InfoLogoCell: BaseTableViewCell {
    override class func description() -> String {
        return "InfoLogoCell"
    }
    
    let containerView = UIView()
    
    let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    let titleLabel = UILabel()
    
    let seperatorView = UIView()
    
    override func setupViews() {
        super.setupViews()
        configureView()
        contentView.addSubview(containerView)
        [logoImageView, titleLabel, seperatorView].forEach { (view) in
            containerView.addSubview(view)
        }
        
        containerView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 160)
        logoImageView.setAnchor(top: containerView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
       
        titleLabel.setAnchor(top: logoImageView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        [logoImageView, titleLabel].forEach { (view) in
            view.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        }
        
        seperatorView.setAnchor(top: nil, left: containerView.leftAnchor,
                                bottom: containerView.bottomAnchor, right: containerView.rightAnchor,
                                paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 1)
    }
    
    private func configureView(){
        logoImageView.image = #imageLiteral(resourceName: "logo-1")
        logoImageView.layer.masksToBounds = true
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.configureSizeView(height: 80, width: 80)
        
        titleLabel.text = "Yassy Такси версия v 1.0"
        titleLabel.textColor = .lightGray
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        
        seperatorView.backgroundColor = Colors.yassySeperatorGray
    }
}
