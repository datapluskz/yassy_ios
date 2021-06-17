//
//  SOSFloatingContainerVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/10/21.
//

import UIKit

class SOSFloatingContainerVC: UIViewController {
    
    let titleLabel = UILabel()
    
    let descriptionLabel = UILabel()
    
    let sosButtonContainerView = UIView()
    let sosImageView = UIImageView()
    let sosButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    

    private func setupViews(){
        configureView()
        view.backgroundColor = .white
        
        [titleLabel, descriptionLabel, sosButton].forEach { (views) in
            view.addSubview(views)
        }
        
        titleLabel.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        descriptionLabel.setAnchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        sosButton.setAnchor(top: descriptionLabel.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 52, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        sosButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sosButton.addTarget(self, action: #selector(sosBtnTapped), for: .touchUpInside)
    }
    
    @objc func sosBtnTapped(){
        callNumber()
    }
    
    private func callNumber() {
        guard let url = URL(string: "telprompt://112"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func configureView(){
        titleLabel.font = .boldSystemFont(ofSize: 20)
        descriptionLabel.textColor = .lightGray
        descriptionLabel.font = .systemFont(ofSize: 16)
        descriptionLabel.numberOfLines = 0
        
        [titleLabel, descriptionLabel].forEach { (label) in
            label.textAlignment = .center
        }
        
        
        titleLabel.text = "Экстренная ситуация"
        descriptionLabel.text = "При нажатии на кнопку SOS будет\nотправлено СМС уведомление\nближайшим водителям о вашей просьбе\nпомощи! Нажмите и удерживайте для\nактивации функции SOS"
        
        sosButton.backgroundColor = .white
        sosButton.setCellShadowTwo()
        sosButton.layer.cornerRadius = 8
        
        sosButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        sosButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        sosButton.setImage(#imageLiteral(resourceName: "ic_emergency").withRenderingMode(.alwaysOriginal), for: .normal)

    }

}
