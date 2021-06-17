//
//  InfoDetailVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 6/4/21.
//

import UIKit

class InfoDetailVC: UIViewController {
    
    var navigationTitle: String
    
    let tableView = UITableView(frame: .zero)
    
    init(navigationTitle: String){
        self.navigationTitle = navigationTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupNavigationBar(){
        self.title = navigationTitle
        navigationItem.leftBarButtonItem = navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupTableView(){
        view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                            bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        tableView.register(InfoDetailCell.self, forCellReuseIdentifier: InfoDetailCell.description())
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension InfoDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InfoDetailCell.description(), for: indexPath) as! InfoDetailCell
        cell.generateCell(TextConstants.brokenSecondAdditionalTitle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
