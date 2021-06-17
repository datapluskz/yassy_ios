//
//  CloseTableViewCell.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 05.05.2021.
//

import UIKit

class CloseTableViewCell: UITableViewCell {
    
    var icon = UIImageView()
    let titleLabel = UILabel()
    
    var data: CloseItems? {
        didSet {
            guard let data = data else {
                return
            }
            icon = data.image
            titleLabel.text = data.title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        [icon, titleLabel].forEach {
            addSubview($0)
        }
        
        [icon, titleLabel].forEach { Y in
            Y.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
        
        icon.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        titleLabel.anchor(top: nil, leading: icon.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        icon.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        configureView()
    }
    
    func configureView() {
        titleLabel.configureLabel(text: "", textColor: .black, textAlignment: .natural, fontName: "", fontSize: 12, numberOfLines: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
