//
//  ProfileInfoCell.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 04.05.2021.
//

import UIKit

class ProfileInfoCell: BaseTableViewCell {
    
    override class func description() -> String {
        return "ProfileInfoCell"
    }
    
    let containerView = UIView()
    let infoImageView = UIImageView()
    let titleLabel = UILabel()
    let seperatorView = UIView()
    let disclosureImageView = UIImageView()
    
    override func setupViews() {
        super.setupViews()
        configureViews()
        contentView.addSubview(containerView)
        [infoImageView, titleLabel, seperatorView, disclosureImageView].forEach { (view) in
            containerView.addSubview(view)
        }
        containerView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                                bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                                paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 60)
        infoImageView.setAnchor(top: nil, left: contentView.leftAnchor,
                                bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30,
                                paddingBottom: 0, paddingRight: 0)
        
        titleLabel.setAnchor(top: nil, left: infoImageView.rightAnchor,
                             bottom: nil, right: nil,
                             paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0)
        
        disclosureImageView.setAnchor(top: nil, left: nil, bottom: nil, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 26)
        
        [infoImageView, titleLabel].forEach { (view) in
            view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        }
        
       
        disclosureImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        seperatorView.setAnchor(top: nil, left: containerView.leftAnchor,
                                bottom: containerView.bottomAnchor, right: containerView.rightAnchor,
                                paddingTop: 16, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 1)
    }
    
    fileprivate func configureViews(){
        infoImageView.contentMode = .scaleAspectFit
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 16)
        seperatorView.backgroundColor = Colors.yassySeperatorGray
        disclosureImageView.image = UIImage(named: "ic_next")?.withRenderingMode(.alwaysOriginal)
        disclosureImageView.contentMode = .scaleAspectFit
    }
    
    func generateCell(_ model: Model){
        let image = UIImage(named: model.imageName)?.withRenderingMode(.alwaysOriginal)
        infoImageView.image = image
        titleLabel.text = model.title
    }
}
