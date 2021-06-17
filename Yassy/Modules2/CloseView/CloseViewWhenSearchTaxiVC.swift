//
//  CloseViewWhenSearchTaxiVC.swift
//  OrangeTaxi
//
//  Created by Tanirbergen Kaldibai on 29.05.2021.
//

import UIKit

class CloseViewWhenSearchTaxiVC: UIViewController {
    
    var viewModel: MainViewModel!
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoading(timer: 1, centerY: 0)
        configureView()
        updateView()
    }
    
    private func configureView() {
        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
        view.backgroundColor = .white
    }
    
    private func updateView() {
        
        viewModel.closeOne { [unowned self] in
            guard let reseon = viewModel.closeOne.last?.reason else { return }
            print("TEEEEEEEEEES\(reseon)")
            RequestID.reaseon = reseon
        }
        
        viewModel.closeEnd(id: "\(RequestID.requestID)", reseon: RequestID.reaseon) {
            print("CloseIsTrue")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            let vc = UINavigationController(rootViewController: HomeVC(viewModel: HomeViewModel(dataManager: DataManager()), addressViewModel: MainViewModel(dataManager: DataManager()), lat: 0.0, lng: 0.0))
            let thisView = CloseViewWhenSearchTaxiVC(viewModel: MainViewModel(dataManager: DataManager()))
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            thisView.dismiss(animated: false) {
                print("deinit true")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
