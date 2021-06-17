//
//  BrokenOrangeTitleCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/30/21.
//

import UIKit

class BrokenOrangeTitleCell: BaseTableViewCell {
    override class func description() -> String {
        return "BrokenOrangeTitleCell"
    }
    
    
    let titleLabel = UILabel()
    
    override func setupViews() {
        super.setupViews()
        titleLabel.textColor = .yassyOrange
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 14)
        contentView.addSubview(titleLabel)
        titleLabel.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 12, paddingLeft: 24, paddingBottom: -12, paddingRight: 24)
    }
    
    func generateCell(title: String){
        titleLabel.text = title
    }
}
