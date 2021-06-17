//
//  LogoutCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 09.05.2021.
//

import UIKit

class LogoutCell: BaseSecondTableViewCell {
    override class func description() -> String {
        return "LogoutCell"
    }
    
    let itemImageView = UIImageView()
    let itemTitleLabel = UILabel()
    
    lazy var stackView = UIStackView(arrangedSubviews: [itemImageView, itemTitleLabel])
    
    override func setupViews() {
        super.setupViews()
        itemImageView.image = UIImage(named: "ic_logout")
        itemImageView.contentMode = .scaleAspectFit
        itemTitleLabel.font = .systemFont(ofSize: 16)
        itemTitleLabel.textAlignment = .left
        itemTitleLabel.text = "Выйти"
        stackView.axis = .horizontal
        stackView.spacing = 16
        
        contentView.addSubview(stackView)
        
        stackView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                            bottom: contentView.bottomAnchor, right: nil,
                            paddingTop: 18, paddingLeft: 24, paddingBottom: -18, paddingRight: 0)
    }
}
