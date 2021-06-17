//
//  AddressSuggestsCell.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import UIKit

class AddressSuggestsCell: BaseTableViewCell {
    override class func description() -> String {
        return "AddressSuggestsCell"
    }
    
    let pinImageView = UIImageView()
    let addressLabel = UILabel()
    let seperatorGray = UIView()
    
    override func setupViews() {
        super.setupViews()
        configureViews()
        
        [pinImageView, addressLabel, seperatorGray].forEach { (view) in
            contentView.addSubview(view)
        }
        
        pinImageView.setAnchor(top: nil, left: contentView.leftAnchor,
                               bottom: nil, right: nil,
                               paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 0)
        pinImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        addressLabel.setAnchor(top: contentView.topAnchor, left: pinImageView.rightAnchor,
                               bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                               paddingTop: 20, paddingLeft: 12, paddingBottom: -20, paddingRight: 32)
    }
    
    private func configureViews(){
        pinImageView.image = UIImage(named: "ic_pin_gray")?.withRenderingMode(.alwaysOriginal)
        pinImageView.contentMode = .scaleAspectFit
        addressLabel.font = .systemFont(ofSize: 15)
        addressLabel.textAlignment = .left
        addressLabel.numberOfLines = 0
        seperatorGray.backgroundColor = Colors.yassySeperatorGray
    }
    
    func generateCell(_ addressData: SearchAddress){
        addressLabel.text = addressData.value
    }
}
