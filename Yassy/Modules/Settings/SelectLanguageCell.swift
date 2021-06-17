//
//  SelectLanguageCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import UIKit

class SelectLanguageCell: BaseTableViewCell {
    override class func description() -> String {
        return "SelectLanguageCell"
    }
    
    let containerView = UIView()
    
    let iconImageView = UIImageView()
    
    let titleLabel = UILabel()
    
    let seperatorView = UIView()
    
    let soonLabel = UILabel()
    let tickImageView = UIImageView()
    
    override func setupViews() {
        super.setupViews()
        configureView()
        contentView.addSubview(containerView)
        [iconImageView, titleLabel, soonLabel, tickImageView ,seperatorView].forEach { (view) in
            containerView.addSubview(view)
        }
        
        containerView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50)
        iconImageView.setAnchor(top: nil, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 28, paddingBottom: 0, paddingRight: 0)
       
        titleLabel.setAnchor(top: nil, left: iconImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 12, paddingBottom: 0, paddingRight: 0)
        
        seperatorView.setAnchor(top: nil, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 1)
        
        tickImageView.setAnchor(top: nil, left: nil, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 32)
        
        soonLabel.setAnchor(top: nil, left: nil, bottom: nil, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 32)
        
        [iconImageView, titleLabel, soonLabel, tickImageView].forEach { (view) in
            view.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        }
    }
    
    private func configureView(){
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 16)
        seperatorView.backgroundColor = Colors.yassySeperatorGray
        soonLabel.font = .systemFont(ofSize: 16)
        soonLabel.textColor = .yassyLight
        soonLabel.text = "Скоро"
        tickImageView.image = UIImage(named: "ic_tick_final")
    }
    
    func generateCell(_ model: PaymentMethods){
        iconImageView.image = UIImage(named: model.imageName)
        titleLabel.text = model.title
        if model.isDifferent {
            tickImageView.isHidden = true
            titleLabel.textColor = .yassyLight
        } else {
            soonLabel.isHidden = true
        }
    }
}
