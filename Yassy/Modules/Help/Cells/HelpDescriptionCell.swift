//
//  HelpDescriptionCell.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 08.05.2021.
//

import UIKit

class HelpDescriptionCell: BaseTableViewCell {
    override class func description() -> String {
        return "HelpDescriptionCell"
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    let commentTextField = CustomLineTextField(placeHolder: "Комментарий")
    
    override func setupViews() {
        super.setupViews()
        [descriptionLabel, commentTextField].forEach { (view) in
            contentView.addSubview(view)
        }
        descriptionLabel.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                                   bottom: nil, right: contentView.rightAnchor,
                                   paddingTop: 12, paddingLeft: 24, paddingBottom: -12, paddingRight: 24)
        commentTextField.setAnchor(top: descriptionLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 24, paddingBottom: -24, paddingRight: 24)
    }
    
   
    
    func generateCell(_ description: String){
        descriptionLabel.text = description
    }
}
