//
//  HelpFilesCell.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 08.05.2021.
//

import UIKit

class HelpFilesCell: BaseTableViewCell {
    override class func description() -> String {
        return "HelpFilesCell"
    }
    
    let deleteButton = UIButton(type: .system)
    let fileNameLabel = UILabel()
    let seperatorView = UIView()
    
    override func setupViews() {
        super.setupViews()
        configureViews()
        [deleteButton, fileNameLabel, seperatorView].forEach { (views) in
            contentView.addSubview(views)
        }
        fileNameLabel.setAnchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 24, paddingBottom: 0, paddingRight: 48)
        deleteButton.setAnchor(top: contentView.topAnchor, left: nil, bottom: nil, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 24)
        seperatorView.setAnchor(top: fileNameLabel.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 16, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 1)
    }
    
    private func configureViews(){
        fileNameLabel.font = .systemFont(ofSize: 16)
        fileNameLabel.textAlignment = .left
        fileNameLabel.numberOfLines = 0
        seperatorView.backgroundColor = Colors.yassySeperatorGray
        deleteButton.setImage(#imageLiteral(resourceName: "ic_delete").withRenderingMode(.alwaysOriginal), for: .normal)
    }
    
    func generateCell(fileName: String){
        fileNameLabel.text = fileName
    }
}
