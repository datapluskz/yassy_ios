//
//  InfoFooterCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import UIKit

class InfoFooterCell: BaseTableViewCell {
    override class func description() -> String {
        return "InfoFooterCell"
    }
    
    let containerView = UIView()
    
    let titleLabel = UILabel()
    
    override func setupViews() {
        super.setupViews()
        titleLabel.text = "2021 Yassy Taxi"
        titleLabel.textColor = .lightGray
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textAlignment = .left
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 40)
        titleLabel.setAnchor(top: nil, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
    }
    
    
}

