//
//  AddFavouriteAddressCell.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import UIKit

class AddFavouriteAddressCell: BaseTableViewCell {
    override class func description() -> String {
        return "AddFavouriteAddressCell"
    }
    
    let containerView = UIView()
    let iconImageView = UIImageView()
    let titleLabel = UILabel()
    let seperatorView = UIView()
    
    override func setupViews() {
        super.setupViews()
        configureViews()
        contentView.addSubview(containerView)
        [iconImageView, titleLabel, seperatorView].forEach { (view) in
            containerView.addSubview(view)
        }
        
        containerView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                                bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                                paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 56)
                                    
        iconImageView.setAnchor(top: nil, left: contentView.leftAnchor,
                                bottom: nil, right: nil, paddingTop: 0, paddingLeft: 30,
                                paddingBottom: 0, paddingRight: 0)
        
        titleLabel.setAnchor(top: nil, left: iconImageView.rightAnchor,
                             bottom: nil, right: nil,
                             paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0)
        
        [iconImageView, titleLabel].forEach { (view) in
            view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        }
        
        seperatorView.setAnchor(top: nil, left: containerView.leftAnchor,
                                bottom: containerView.bottomAnchor, right: containerView.rightAnchor,
                                paddingTop: 16, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 1)
    }
    
    fileprivate func configureViews(){
        iconImageView.contentMode = .scaleAspectFit
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 16)
        seperatorView.backgroundColor = Colors.yassySeperatorGray
    }
    
    func generateCell(_ model: Model){
        let image = UIImage(named: model.imageName)!
        iconImageView.image = image.withTintColor(.yassyOrange, renderingMode: .alwaysOriginal)
        titleLabel.text = model.title
    }
}
