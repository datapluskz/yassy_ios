//
//  HelpDetailVC.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 06.05.2021.
//

import UIKit
import Photos

class HelpDetailVC: UIViewController {
    
    let tableView = UITableView(frame: .zero)
    
    let sendButton = UIButton(type: .system)
    
    var filesArray = [String]()
    var imagesArray: [UIImage]?
    
    var descriptionText: String
    var navigationTitleText: String
    var orangeTitle: String
    var id: Int
    var secondId: Int
    
    let imagePicker = UIImagePickerController()
    
    init(descriptionText: String, navigationTitleText: String, orangeTitle: String, id: Int, secondId: Int) {
        self.descriptionText = descriptionText
        self.navigationTitleText = navigationTitleText
        self.orangeTitle = orangeTitle
        self.id = id
        self.secondId = secondId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    fileprivate func setupViews(){
        view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        setupSendButton()
       
    }
    
    private func setupSendButton(){
        sendButton.backgroundColor = .yassyOrange
        sendButton.setTitle("Отправить", for: .normal)
        sendButton.setTitleColor(.white, for: .normal)
        sendButton.layer.cornerRadius = 8
        sendButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        tableView.addSubview(sendButton)
        sendButton.setAnchor(top: nil, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 50)
    }
    
    private func setupNavigationBar(){
        navigationItem.leftBarButtonItem = self.navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationItem.title = navigationTitleText
    }
    
    private func setupTableView(){
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        tableView.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                            paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        [HelpDescriptionCell.self, HelpFilesCell.self, HelpAttachFileCell.self, BrokenOrangeTitleCell.self].forEach { (cell) in
            tableView.register(cell, forCellReuseIdentifier: cell.description())
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func removeButtonTapped(_ sender: UIButton){
        let center = sender.center
        guard let point = sender.superview?.convert(center, to: self.tableView) else { return }
        guard let indexPath = self.tableView.indexPathForRow(at: point) else { return }
        self.filesArray.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
        self.perform(#selector(reloadTableView), with: nil, afterDelay: 2)
    }
    
    @objc func reloadTableView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension HelpDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if id == 2 {
            return 4
        } else {
            return 3
        }
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if id == 2 {
            switch section {
            case 2:
                return filesArray.count
            default:
                return 1
            }
        } else {
            switch section {
            case 0:
                return 1
            case 1:
                return filesArray.count
            default:
                return 1
            }
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if id == 2 {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: BrokenOrangeTitleCell.description(), for: indexPath) as! BrokenOrangeTitleCell
                cell.generateCell(title: orangeTitle)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: HelpDescriptionCell.description(), for: indexPath) as! HelpDescriptionCell
                cell.generateCell(descriptionText)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: HelpFilesCell.description(), for: indexPath) as! HelpFilesCell
                
                cell.generateCell(fileName: filesArray[indexPath.row] )
                
                cell.deleteButton.addTarget(self, action: #selector(removeButtonTapped(_:)), for: .touchUpInside)
                
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: HelpAttachFileCell.description(), for: indexPath) as! HelpAttachFileCell
                return cell
            }
        } else {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: HelpDescriptionCell.description(), for: indexPath) as! HelpDescriptionCell
                cell.generateCell(descriptionText)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: HelpFilesCell.description(), for: indexPath) as! HelpFilesCell
                
                cell.generateCell(fileName: filesArray[indexPath.row] )
                
                cell.deleteButton.addTarget(self, action: #selector(removeButtonTapped(_:)), for: .touchUpInside)
                
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: HelpAttachFileCell.description(), for: indexPath) as! HelpAttachFileCell
                return cell
            }
        }
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if id == 2 {
            
            if indexPath.section == 0 {
                if secondId == 0 {
                    let vc = HelpOnlyTextVC(navigationTitle: orangeTitle, descriptionText: TextConstants.brokenFirstAdditionalTitle)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                if secondId == 1 {
                    let vc = HelpOnlyTextVC(navigationTitle: orangeTitle, descriptionText: TextConstants.brokenSecondAdditionalTitle)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                if secondId == 2 {
                    let vc = HelpOnlyTextVC(navigationTitle: orangeTitle, descriptionText: TextConstants.brokenThirdAddtinionalTitle)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
              
            }
            
            if indexPath.section == 3 {
                self.present(imagePicker, animated: true, completion: nil)
            }
        } else {
            if indexPath.section == 2 {
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
      
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if id == 2 {
            switch section {
            case 3:
                return UIView()
            default:
                return nil
            }
        } else {
            switch section {
            case 2:
                return UIView()
            default:
                return nil
            }
        }
     
     
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if id == 2 {
            switch section {
            case 3:
                return 60
            default:
                return 0
            }
        } else {
            switch section {
            case 2:
                return 60
            default:
                return 0
            }
        }
        
       
    }
}

extension HelpDetailVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
            let fileName = fileUrl.lastPathComponent
            filesArray.append(fileName)
            print(fileName)
            imagesArray?.append(image)
        }
        dismiss(animated: true, completion: nil)
        print("Files arra is", filesArray as Any)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
