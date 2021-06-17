//
//  SearchView.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 21.05.2021.
//

import UIKit

class SearchView: UIView {
    
    // MARK: - Properties
    lazy var searchCar = UILabel()
    lazy var subSearhCar = UILabel()
    lazy var closeButton = UIButton(type: .system)
    let sizeScreen = UIScreen.main.bounds.height
    lazy var stachSearchLabel: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            searchCar,
            subSearhCar
        ])
        
        sv.axis = .vertical
        sv.spacing = 8
        return sv
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureView()
        heightAnchor.constraint(equalToConstant: sizeScreen / 3).isActive = true
        layer.cornerRadius = 16
        shadowView()
    }
    
    // MARK: - Methods
    private func configureView() {
        backgroundColor = .white
        setupLayouts()
    }
    
    private func setupLayouts() {
        [stachSearchLabel, closeButton].forEach {
            addSubview($0)
        }
        stachSearchLabel.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        stachSearchLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        closeButton.anchor(top: stachSearchLabel.safeAreaLayoutGuide.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 24, left: 32, bottom: 0, right: 32))
        closeButton.buttonLeftImage(image: #imageLiteral(resourceName: "cancel_icon"), renderMode: .alwaysOriginal)
        closeButton.buttonTitlePadding(top: 0, left: 120, bottom: 0, right: 0)
        configureLayouts()
    }
    
    private func configureLayouts() {
        searchCar.configureLabel(text: "Поиск машины", textColor: .black, textAlignment: .center, fontName: Fonts.appleFont, fontSize: 25, numberOfLines: 0)
        subSearhCar.configureLabel(text: "Ищем ближайщие машины\n доступные для вашей поездки.", textColor: .gray, textAlignment: .center, fontName: Fonts.appleFont, fontSize: 15, numberOfLines: 0)
        closeButton.configureButton(title: "Отмена", titleColor: .black, isEnabled: true, cornerRadius: 12, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .white)
        closeButton.shadowView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
