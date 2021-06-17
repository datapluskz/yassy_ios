//
//  MenuItemsCell.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import UIKit

class MenuItemsCell: BaseSecondTableViewCell {
    override class func description() -> String {
        return "MenuItemsCell"
    }
    
    let itemImageView = UIImageView()
    let itemTitleLabel = UILabel()
    
    lazy var stackView = UIStackView(arrangedSubviews: [itemImageView, itemTitleLabel])
    
    override func setupViews() {
        super.setupViews()
        itemImageView.contentMode = .scaleAspectFit
        itemTitleLabel.font = .systemFont(ofSize: 16)
        itemTitleLabel.textAlignment = .left
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        contentView.addSubview(stackView)
        
        stackView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                            bottom: contentView.bottomAnchor, right: nil,
                            paddingTop: 18, paddingLeft: 24, paddingBottom: -18, paddingRight: 0)
    }
    
    
}

