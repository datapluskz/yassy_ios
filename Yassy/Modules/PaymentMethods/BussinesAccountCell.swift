//
//  BussinesAccountCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/12/21.
//

import UIKit

class BussinesAccountCell: BaseTableViewCell {
    override class func description() -> String {
        return "BussinesAccountCell"
    }
    
    
    let containerView = UIView()
    let seperatorView = UIView()
    
    let iconImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
    let titlelabel = UILabel()
    let subTitleLabel = UILabel()
    
    override func setupViews() {
        super.setupViews()
        configureView()
        contentView.addSubview(containerView)
        [seperatorView, iconImageView, titlelabel, subTitleLabel].forEach { (view) in
            containerView.addSubview(view)
        }
        containerView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                                bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                                paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 60)
        seperatorView.setAnchor(top: nil, left: containerView.leftAnchor,
                                bottom: containerView.bottomAnchor, right: containerView.rightAnchor,
                                paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, height: 1)
        
        iconImageView.setAnchor(top: nil, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        titlelabel.setAnchor(top: nil, left: iconImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0)
        titlelabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor).isActive = true
        
        subTitleLabel.setAnchor(top: nil, left: nil, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 20)
        subTitleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
    
    private func configureView(){
        seperatorView.backgroundColor = Colors.yassySeperatorGray
        iconImageView.layer.masksToBounds = true
        iconImageView.contentMode = .scaleAspectFill
        iconImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        titlelabel.font = .systemFont(ofSize: 16)
        titlelabel.text = "Компания"
        subTitleLabel.text = "Тестовая компания"
        
        subTitleLabel.textColor = .lightGray
        subTitleLabel.font = .systemFont(ofSize: 14)
    }
    
    func generateCell(_ model: PaymentMethods){
        titlelabel.text = model.title
        iconImageView.image = UIImage(named: model.imageName)
    }
}
