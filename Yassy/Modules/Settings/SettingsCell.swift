//
//  SettingsCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import UIKit

class SettingsCell: BaseTableViewCell {
    override class func description() -> String {
        return "SettingsCell"
    }
    
    let containerView = UIView()
    let titleLabel = UILabel()
    let seperatorView = UIView()
    let disclosureImageView = UIImageView()
    
    
    override func setupViews() {
        super.setupViews()
        configureView()
        contentView.addSubview(containerView)
        [titleLabel, seperatorView, disclosureImageView].forEach { (view) in
            containerView.addSubview(view)
        }
        containerView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                                bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                                paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 60)
        
        titleLabel.setAnchor(top: nil, left: containerView.leftAnchor,
                             bottom: nil, right: nil,
                             paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0)
        
        disclosureImageView.setAnchor(top: nil, left: nil, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 26)
        
        [disclosureImageView, titleLabel].forEach { (view) in
            view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        }
        
       
        disclosureImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        seperatorView.setAnchor(top: nil, left: containerView.leftAnchor,
                                bottom: containerView.bottomAnchor, right: containerView.rightAnchor,
                                paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 1)
    }
    
    private func configureView(){
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 16)
        seperatorView.backgroundColor = Colors.yassySeperatorGray
        disclosureImageView.image = UIImage(named: "ic_next")?.withRenderingMode(.alwaysOriginal)
        disclosureImageView.contentMode = .scaleAspectFit
    }
    
    func generateCell(_ model: SettingsModel){
        titleLabel.text = model.title
        if model.isDifferent {
            disclosureImageView.isHidden = true
        }
    }
}
