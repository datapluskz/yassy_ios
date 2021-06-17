//
//  YassyNotWorking.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 20.05.2021.
//

import UIKit

class YassyNotWorking: UIView {
    
    let sizeScrean = UIScreen.main.bounds.height
    
    let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    lazy var bottomView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 13
        view.shadowView()
        view.backgroundColor = .white
        view.setCellShadowTwo()
        view.alpha = 1
        return view
    }()
    
    let bottomViewLabel: UILabel = {
        let lb = UILabel()
        lb.text = "К сожалению, мы\n не работаем в вашем регионе"
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.font = UIFont(name: Fonts.appleFont, size: 16)
        return lb
    }()
    
    let bottomViewImage: UIImageView = {
        let imgName = UIImage(named: "location.pdf")
        let img = UIImageView(image: imgName)
        imgName?.withRenderingMode(.alwaysOriginal)
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
        setupView()
    }
    
    private func configureView() {
        backgroundColor = .clear
        alpha = 0
    }
    
    private func setupView() {
        addSubview(backgroundView)
        backgroundView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
        addSubview(bottomView)
        bottomView.anchor(top: nil, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 44, bottom: 0, right: 44))
        bottomView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: sizeScrean / 3).isActive = true
        bottomViewLayouts()
    }
    
    private func bottomViewLayouts() {
        [bottomViewLabel, bottomViewImage].forEach {
            bottomView.addSubview($0)
        }
        
        [bottomViewLabel, bottomViewImage].forEach { configure in
            configure.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        }
        
        bottomViewLabel.anchor(top: bottomView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        bottomViewImage.anchor(top: bottomViewLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
