//
//  MenuHeaderCell.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import UIKit

class MenuHeaderCell: BaseTableViewCell {
    override class func description() -> String {
        return "MenuHeaderCell"
    }
    
    let userNameLabel = UILabel()
    
    let seperatorView = UIView()
    
    override func setupViews() {
        super.setupViews()
        seperatorView.backgroundColor = .lightGray
        userNameLabel.text = "+7 702 277 7083"
        userNameLabel.font = .boldSystemFont(ofSize: 20)
        userNameLabel.textAlignment = .left
        contentView.addSubview(userNameLabel)
        contentView.addSubview(seperatorView)
        userNameLabel.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 50, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
        seperatorView.setAnchor(top: userNameLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: -18, paddingRight: 0, height: 0.4)
    }
}

