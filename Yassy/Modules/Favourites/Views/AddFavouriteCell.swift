//
//  AddFavouriteCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 12.05.2021.
//

import UIKit

class AddFavouriteCell: BaseSecondTableViewCell {
    override class func description() -> String {
        return "AddFavouriteCell"
    }
    
    let containerView = UIView()
    let infoImageView = UIImageView()
    let titleLabel = UILabel()
    let seperatorView = UIView()
    
    override func setupViews() {
        super.setupViews()
        configureViews()
        contentView.addSubview(containerView)
        [infoImageView, titleLabel, seperatorView].forEach { (view) in
            containerView.addSubview(view)
        }
        containerView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                                bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                                paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 60)
        infoImageView.setAnchor(top: nil, left: containerView.leftAnchor,
                                bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30,
                                paddingBottom: 0, paddingRight: 0)
        
        titleLabel.setAnchor(top: nil, left: containerView.leftAnchor,
                             bottom: nil, right: containerView.rightAnchor,
                             paddingTop: 0, paddingLeft: 62, paddingBottom: 0, paddingRight: 30)
        
        [infoImageView, titleLabel].forEach { (view) in
            view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        }
        
        seperatorView.setAnchor(top: nil, left: containerView.leftAnchor,
                                bottom: containerView.bottomAnchor, right: containerView.rightAnchor,
                                paddingTop: 16, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 1)
    }
    
    fileprivate func configureViews(){
        infoImageView.contentMode = .scaleAspectFit
        infoImageView.image = UIImage(named: "ic_add_medium")?.withRenderingMode(.alwaysOriginal)
        titleLabel.text = "Другой адрес"
        titleLabel.textColor = .yassyOrange
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 16)
        seperatorView.backgroundColor = Colors.yassySeperatorGray
    }
    
    func generateCell(_ addressModel: AddressModel) {
        titleLabel.text = addressModel.address
    }
}


