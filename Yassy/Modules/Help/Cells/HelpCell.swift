//
//  HelpCell.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 06.05.2021.
//

import UIKit

class HelpCell: BaseTableViewCell {
    override class func description() -> String {
        return "HelpCell"
    }
    
    let helpLabel = UILabel()
    let seperatorView = UIView()
    let disclosureImageView = UIImageView()
    override func setupViews() {
        super.setupViews()
        helpLabel.font = .systemFont(ofSize: 16)
        disclosureImageView.image = UIImage(named: "ic_next")?.withRenderingMode(.alwaysOriginal)
        disclosureImageView.contentMode = .scaleAspectFit
        helpLabel.textAlignment = .left
        seperatorView.backgroundColor = Colors.yassySeperatorGray
        contentView.addSubview(helpLabel)
        contentView.addSubview(seperatorView)
        contentView.addSubview(disclosureImageView)
        helpLabel.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 24, paddingBottom: 0, paddingRight: 0)
        disclosureImageView.setAnchor(top: nil, left: nil, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 26)
        disclosureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        seperatorView.setAnchor(top: helpLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 1)
    }
    
    func generateCell(_ help: String){
        helpLabel.text = help
    }
}
