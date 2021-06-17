//
//  RouteTableViewCell.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 31.05.2021.
//

import UIKit

class RouteTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Маршрут"
        label.textColor = .yassyLight
        label.textAlignment = .natural
        label.font = UIFont(name: Fonts.appleFont, size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let s_addressLabel: UILabel = {
        let label = UILabel()
        label.text = AddressInformation.s_address
        label.textColor = .black
        label.font = UIFont(name: Fonts.regular, size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let d_addressLabel: UILabel = {
        let label = UILabel()
        label.text = AddressInformation.d_address
        label.textColor = .black
        label.font = UIFont(name: Fonts.regular, size: 18)
        label.numberOfLines = 0
        return label
    }()
    
    let s_addressIcon = UIImageView(image: #imageLiteral(resourceName: "point").withRenderingMode(.alwaysOriginal))
    let d_addressIcon = UIImageView(image: #imageLiteral(resourceName: "orangePoint").withRenderingMode(.alwaysOriginal))

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureCell()
        setupLayouts()
    }
    
    private func configureCell() {
        backgroundColor = .white
        heightAnchor.constraint(equalToConstant: 130).isActive = true
    }
    
    private func setupLayouts() {
        [titleLabel, s_addressIcon, d_addressIcon, d_addressIcon, s_addressLabel, d_addressLabel].forEach {
            addSubview($0)
        }
        titleLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0))
        s_addressIcon.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0))
        d_addressIcon.anchor(top: s_addressIcon.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 16, left: 20, bottom: 0, right: 0))
        s_addressLabel.anchor(top: nil, leading: s_addressIcon.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        s_addressLabel.centerYAnchor.constraint(equalTo: s_addressIcon.centerYAnchor).isActive = true
        
        d_addressLabel.anchor(top: nil, leading: d_addressIcon.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        d_addressLabel.centerYAnchor.constraint(equalTo: d_addressIcon.centerYAnchor).isActive = true
    }

}
