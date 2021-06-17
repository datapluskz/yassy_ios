//
//  AddCardCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/3/21.
//

import UIKit

class AddCardCell: BaseTableViewCell {
    override class func description() -> String {
        return "AddCardCell"
    }
    
    let containerView = UIView()
    
    let iconImageView = UIImageView()
    
    let titleLabel = UILabel()
    
    let seperatorView = UIView()
    
    override func setupViews() {
        super.setupViews()
        configureView()
        contentView.addSubview(containerView)
        [iconImageView, titleLabel, seperatorView].forEach { (view) in
            containerView.addSubview(view)
        }
        
        containerView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50)
        iconImageView.setAnchor(top: nil, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 28, paddingBottom: 0, paddingRight: 0)
       
        titleLabel.setAnchor(top: nil, left: iconImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0)
        
        seperatorView.setAnchor(top: nil, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 1)
        
        [iconImageView, titleLabel].forEach { (view) in
            view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        }
    }
    
    private func configureView(){
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 16)
        seperatorView.backgroundColor = Colors.yassySeperatorGray
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "ic_add_medium")?.withTintColor(.yassyLight)
        titleLabel.textColor = .yassyLight
        titleLabel.text = "Привязать карту"
    }
}
