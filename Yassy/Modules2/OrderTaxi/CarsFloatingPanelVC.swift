//
//  CarsFloatingPanelVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/15/21.
//

import UIKit

class CarsFloatingPanelVC: UIViewController {
    
    var carsModel: [Cars]?
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = true
        return cv
    }()
    
    let zakazButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.backgroundColor = .yassyOrange
        btn.layer.cornerRadius = 8
        btn.setTitle("Заказать", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(zakazButton)
        collectionView.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 32, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 250)
        zakazButton.setAnchor(top: collectionView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 50)
        collectionView.register(CarsCell.self, forCellWithReuseIdentifier: CarsCell.description())
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CarsFloatingPanelVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carsModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarsCell.description(), for: indexPath) as! CarsCell
        if let model = carsModel?[indexPath.item] {
            cell.generateCell(model)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension CarsFloatingPanelVC: ParsePriceProtocol {
    
    func parsePrice(standart: String, comfort: String) {
        carsModel = [Cars(imageName: "standart_car", title: "Стандарт", price: standart, descriptionLabel: "Быстро и доступно!"),
                     Cars(imageName: "komfort_car", title: "Комфорт", price: comfort, descriptionLabel: "Комфортная поездка с опытным\nводителем")]
    }
    
    
}
