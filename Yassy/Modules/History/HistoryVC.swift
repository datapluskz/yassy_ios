//
//  HistoryVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 08.05.2021.
//

import UIKit

class HistoryVC: BaseViewController {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        let cv = UICollectionView(frame: .zero,
                                  collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    var viewModel: HistoryViewModel
    
    init(viewModel: HistoryViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSideMenu()
        setupViews()
        callingViewModelForUIUpdate()
    }
    
    fileprivate func setupViews(){
        view.backgroundColor = .white
        title = "История заказов"
        view.addSubview(collectionView)
        collectionView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                                 bottom: view.bottomAnchor, right: view.rightAnchor,
                                 paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        collectionView.register(HistoryCell.self, forCellWithReuseIdentifier: HistoryCell.description())
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func callingViewModelForUIUpdate(){
        viewModel.bindHistoryArrayDataToController = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

  

}

extension HistoryVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let id = viewModel.historyData?[indexPath.item].id {
            let vc = HistoryDetailVC(viewModel: HistoryDetailViewModel(apiService: HistoryDataManager(), requestId: id))
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HistoryVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 48, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
}

extension HistoryVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.historyData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: HistoryCell.description(), for: indexPath) as! HistoryCell
        if let historyData = viewModel.historyData?[indexPath.row] {
            cell.generateCell(historyData)
        }
        return cell
    }
    
    
}
