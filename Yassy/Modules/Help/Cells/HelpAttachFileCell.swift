//
//  HelpAttachFileCell.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 5/30/21.
//

import UIKit

class HelpAttachFileCell: BaseTableViewCell {
    override class func description() -> String {
        return "HelpAttachFileCell"
    }
    
    let paperClipImageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let seperatorView = UIView()
    
    override func setupViews() {
        super.setupViews()
        configureViews()
        [paperClipImageView, titleLabel, descriptionLabel, seperatorView].forEach { (views) in
            contentView.addSubview(views)
        }
        
        paperClipImageView.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0)
        titleLabel.setAnchor(top: contentView.topAnchor, left: paperClipImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 24, paddingLeft: 8, paddingBottom: 0, paddingRight: 0)
        seperatorView.setAnchor(top: titleLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 1)
        descriptionLabel.setAnchor(top: seperatorView.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 8, paddingLeft: 24, paddingBottom: -8, paddingRight: 24)
    }
    
    private func configureViews(){
        paperClipImageView.contentMode = .scaleAspectFit
        paperClipImageView.image = #imageLiteral(resourceName: "ic_paperclip")
        titleLabel.text = "Прикрепить файл"
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textAlignment = .left
        descriptionLabel.textAlignment = .left
        seperatorView.backgroundColor = Colors.yassySeperatorGray
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = .systemFont(ofSize: 12)
        descriptionLabel.text = "Максимум 20 файлов общим размером до 16 МБ"
    }
}
