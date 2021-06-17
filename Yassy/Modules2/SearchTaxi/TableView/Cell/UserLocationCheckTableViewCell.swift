//
//  UserLocationCheckTableViewCell.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 04.05.2021.
//

import UIKit

class UserLocationCheckTableViewCell: UITableViewCell {
    
    lazy var userAddressIcon = UIImageView(image: #imageLiteral(resourceName: "carplay_plus").withRenderingMode(.alwaysOriginal))

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = .white
        // Configure the view for the selected state
    }

}
