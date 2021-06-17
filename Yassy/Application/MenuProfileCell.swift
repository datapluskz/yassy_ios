//
//  MenuProfileCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/22/21.
//

import UIKit

class MenuProfileCell: BaseSecondTableViewCell {
    override class func description() -> String {
        return "MenuProfileCell"
    }
    
    let photoImageView = CustomCircleImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    let nameLabel = UILabel()
    let phoneLabel = UILabel()
    
    lazy var labelStackView = UIStackView(arrangedSubviews: [nameLabel, phoneLabel])
    
    let seperatorView = UIView()
    
    override func setupViews() {
        super.setupViews()
       configureViews()
        contentView.addSubview(photoImageView)
        contentView.addSubview(labelStackView)
        contentView.addSubview(seperatorView)
        
        photoImageView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: -16, paddingRight: 0, width: 80, height: 80)
        labelStackView.setAnchor(top: nil, left: photoImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0)
        labelStackView.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor).isActive = true
        seperatorView.setAnchor(top: nil, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 1)
        
        setupProfile()
    }
    
    private func configureViews(){
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.image = #imageLiteral(resourceName: "avatar2")
        
        nameLabel.textAlignment = .left
        phoneLabel.textAlignment = .left
        
        nameLabel.font = UIFont(name: YassyFonts.mediumFont, size: 16)
        phoneLabel.font = UIFont(name: YassyFonts.regularFont, size: 14)
        nameLabel.textColor = .yassyOrange
        
        nameLabel.text = "Добавить имя"
        phoneLabel.text = "+7 747 423 4042"
        
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        
        seperatorView.backgroundColor = Colors.yassySeperatorGray
     
    }
    
    func setupProfile(){
        let profile = ProfileDataDefaults.getProfileData()
        
        nameLabel.text = profile.name
        phoneLabel.text = profile.phone
        
        if let image = URL(string: "https://my.yassy.taxi/storage/" + profile.image){
            photoImageView.loadImage(from:image)
        }
      
    }
}
