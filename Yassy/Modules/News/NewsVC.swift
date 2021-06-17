//
//  NewsVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/3/21.
//

import UIKit

class NewsVC: BaseViewController {
    
    let tableView = UITableView(frame: .zero)
    
    var viewModel: NewsViewModel
    
    init(viewModel: NewsViewModel){
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
        callToViewModelForUIUpdate()
    }
    

    private func setupViews(){
        view.backgroundColor = .white
        title = "Новости"
        setupTableView()
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.description())
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    private func callToViewModelForUIUpdate(){
        viewModel.bindNewsDataToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

}

extension NewsVC: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.description(), for: indexPath) as! NewsCell
        if let model = viewModel.newsData?[indexPath.row]{
            cell.generateCell(model)
        }
        return cell
    }
    
}

extension NewsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newsModel = viewModel.newsData?[indexPath.row]{
            let vc = NewsDetailVC(newsModel: newsModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
