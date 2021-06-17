//
//  CarsCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/15/21.
//

import UIKit

class CarsCell: BaseCollectionViewCell {
    override class func description() -> String {
        return "CarsCell"
    }
    
    let carImageView = UIImageView()
    
    let titleLabel = UILabel()
    let priceLabel = UILabel()
    
    lazy var labelStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        return stack
    }()
    
    let descriptionLabel = UILabel()
    
    override func setupViews() {
        super.setupViews()
        configureViews()
        
        [carImageView, labelStackView, descriptionLabel].forEach { (views) in
            contentView.addSubview(views)
        }
        
        carImageView.setAnchor(top: contentView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        carImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        labelStackView.setAnchor(top: carImageView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
        
        descriptionLabel.setAnchor(top: labelStackView.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 12, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
    }
    
    private func configureViews(){
        titleLabel.font = .boldSystemFont(ofSize: 20)
        priceLabel.font = .boldSystemFont(ofSize: 22)
        
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = .systemFont(ofSize: 16)
        
        carImageView.contentMode = .scaleAspectFit
        carImageView.image = UIImage(named: "standart_car")
        
        titleLabel.textAlignment = .left
        descriptionLabel.text = "Быстро и доступно!"
        descriptionLabel.numberOfLines = 0
        priceLabel.textAlignment = .right
    }
    
    func generateCell(_ model: Cars) {
        titleLabel.text = model.title
        carImageView.image = UIImage(named: model.imageName)
        descriptionLabel.text = model.descriptionLabel
        priceLabel.text = model.price
    }
}
