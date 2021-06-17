//
//  StartedTableViewCell.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 04.05.2021.
//

import UIKit

struct ConfigureStartedStatus {
    var name: String
    var icon: UIImage
    var subString: String
}

class AddressTableViewCell: UITableViewCell {
    
    lazy var addressLabel = UILabel()
    lazy var addressIcon = UIImageView()
    lazy var addressSubTitle = UILabel()
    let check = true
    
    var data: ConfigureStartedStatus? {
        didSet {
            guard let data = data else {
                return
            }
            addressLabel.text = data.name
            addressIcon.image = data.icon
            addressSubTitle.text = data.subString
        }
    }
    
    lazy var isNotEmtySubtitleStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            addressLabel,
            addressSubTitle
        ])
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = .white
        setupLayouts()
    }
    
    fileprivate func setupLayouts() {
            [addressIcon, addressLabel].forEach {
                addSubview($0)
            }
            
            addressIcon.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 20, bottom: 0, right: 0))
            addressLabel.anchor(top: nil, leading: addressIcon.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
            addressLabel.configureStateLabel(textColor: .black, textAlignment: .natural, fontName: "", fontSize: 23, numberOfLines: 0)
            addressSubTitle.configureStateLabel(textColor: .gray, textAlignment: .natural, fontName: "", fontSize: 23, numberOfLines: 0)
            
            [addressIcon, addressLabel].forEach { Y in
                Y.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                
                if addressSubTitle.text == "" {
                    addressSubTitle.removeFromSuperview()
                    addressLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                }
        }
    }
}
