//
//  CheckViewController.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 09.05.2021.
//

import UIKit

class CheckViewController: UIViewController {
    
    let ratingView = EndedView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        view.addSubview(ratingView)
        ratingView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        ratingView.handleMainButton.addTarget(self, action: #selector(handleShowMainPage), for: .touchUpInside)
    }
    
    @objc fileprivate func handleShowMainPage() {
        let vc = UINavigationController(rootViewController: HomeVC(viewModel: HomeViewModel(dataManager: DataManager()), addressViewModel: MainViewModel(dataManager: DataManager()), lat: 0.0, lng: 0.0))
        let orderVc = UINavigationController(rootViewController: OrderTaxiViewController(viewModel: MainViewModel(dataManager: DataManager()), isTaxiEmty: false))
        let thisVC = UINavigationController(rootViewController: CheckViewController())
        let searchVC = UINavigationController(rootViewController: SearchViewController(dataManager: DataManager(), viewmodel: MainViewModel(dataManager: DataManager()), pulseCheck: false))
        
        orderVc.dismiss(animated: false, completion: nil)
        searchVC.dismiss(animated: false, completion: nil)
        thisVC.dismiss(animated: false, completion: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    deinit {
        print("GOOOOOOOOOOOOOOOD")
    }
}
