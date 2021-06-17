//
//  InfoDetailCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import UIKit

class InfoDetailCell: BaseTableViewCell {
    override class func description() -> String {
        return "InfoDetailCell"
    }
    
    let descriptionLabel = UILabel()
    
    override func setupViews() {
        super.setupViews()
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        contentView.addSubview(descriptionLabel)
        descriptionLabel.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 24, paddingBottom: -16, paddingRight: 24)
    }
    
    func generateCell(_ txt: String){
        descriptionLabel.text = txt
    }
}
