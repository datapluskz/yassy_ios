//
//  FirstCollectionViewCell.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 24.02.2021.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties
    private var imageView   = UIImageView(image: #imageLiteral(resourceName: "City driver-rafiki 2-1").withRenderingMode(.alwaysOriginal))
    private var titleLabel  = UILabel()
    private var subTitleLabel  = UILabel()
    lazy public var nextPageButton = UIButton(type: .system)
    var isSmallDevice = UIScreen.main.bounds.height > 570.0
    
    // MARK: - Stack
    lazy var stackNotificationLabels: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            titleLabel,
            subTitleLabel
        ])
        sv.axis    = .vertical
        sv.spacing = 8
        return sv
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        self.contentView.isUserInteractionEnabled = false
        setupSubviews()
        setupLayouts()
        setupActions()
        print(UIScreen.main.bounds.height)
    }
    
    // MARK: - Methods
    private func setupSubviews() {
        self.contentView.isUserInteractionEnabled = false
        addSubview(imageView)
        imageView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil,padding: .init(top: 40, left: 0, bottom: 0, right: 0))
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        configureView()
    }
    
    private func configureView() {
        addSubview(imageView)
        imageView.configureSizeView(height: isSmallDevice ? 340 : 300, width: isSmallDevice ? 340 : 300)
        //imageView.configureLayerView(radius: isSmallDevice ? 170 : 150)
    }
    
    private func setupLayouts() {
        addSubview(nextPageButton)
        nextPageButton.isUserInteractionEnabled = true
        nextPageButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 32, bottom: 80, right: 32))
        addSubview(stackNotificationLabels)
        stackNotificationLabels.anchor(top: nil, leading: nil, bottom: nextPageButton.topAnchor, trailing: nil,padding: .init(top: 0, left: 0, bottom: 32, right: 0))
        stackNotificationLabels.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        configureLayouts()
    }
    
    private func configureLayouts() {
        nextPageButton.configureButton(title: ONBOARDING_FIRST_PAGE_BUTTON, titleColor: .yassyOrange, isEnabled: true, cornerRadius: 12, borderWidth: 1.0, borderColor: UIColor.yassyOrange.cgColor, height: isSmallDevice ? 50 : 36, backgroundColor: .white)
        titleLabel.configureLabel(text: ONBOARDING_FIRST_PAGE_TITLE, textColor: .black, textAlignment: .center, fontName: "SFProDisplay-Black", fontSize: isSmallDevice ? 24 : 16, numberOfLines: 0)
        subTitleLabel.configureLabel(text: ONBOARDING_FIRST_PAGE_SUB_TITLE, textColor: .lightGray, textAlignment: .center, fontName: "SFProDisplay-Black", fontSize: isSmallDevice ? 16 : 12, numberOfLines: 0)
    }
    
    private func setupActions() {
        nextPageButton.addTarget(self, action: #selector(handleTest), for: .touchUpInside)
    }
    
    @objc private func handleTest() {
        print("1")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
