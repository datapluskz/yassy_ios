//
//  NewsDetailVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/10/21.
//

import UIKit

class NewsDetailVC: UIViewController {
    
    let tableView = UITableView(frame: .zero)
    
    var newsModel: NewsModel
    
    init(newsModel: NewsModel){
        self.newsModel = newsModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    

    private func setupViews(){
        view.backgroundColor = .white
        title = "Новости"
        navigationItem.leftBarButtonItem = navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor,
                            left: view.leftAnchor, bottom: view.bottomAnchor,
                            right: view.rightAnchor, paddingTop: 0, paddingLeft: 0,
                            paddingBottom: 0, paddingRight: 0)
        
        tableView.register(NewsDetailCell.self, forCellReuseIdentifier: NewsDetailCell.description())
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension NewsDetailVC: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsDetailCell.description(), for: indexPath) as! NewsDetailCell
        cell.generateCell(newsModel)
        return cell
    }
    
}

extension NewsDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
