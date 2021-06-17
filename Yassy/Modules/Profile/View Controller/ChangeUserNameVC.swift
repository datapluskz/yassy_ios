//
//  ChangeUserNameVC.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 04.05.2021.
//

import UIKit

protocol ChangeUserNameViewModelInput: AnyObject {
    func changeName(name: String)
}

class ChangeUserNameVC: UIViewController {
    
    var viewModel: ChangeUserNameViewModel
    
    weak var viewModelInput: ChangeUserNameViewModelInput?
    
    init(viewModel: ChangeUserNameViewModel) {
        self.viewModel = viewModel
        self.viewModelInput = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewModelOutput = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameTextField = CustomTextField(placeHolder: "Введите ваше имя")
    lazy var buttonContainerView = UIView()
    lazy var saveButton = UIButton(type: .system)
    let bottomLine = CALayer()
    
    typealias completion = (Bool) -> Void
    var changeCompletion: completion!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureTextField()
    }
    
    fileprivate func setupViews(){
        view.backgroundColor = .white
        setupNavigationBar()
        view.addSubview(nameTextField)
        nameTextField.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
        nameTextField.addTarget(self, action: #selector(handleEnableButton(_:)), for: .allEditingEvents)
        addSearchMapButton()
    }
    
    private func setupNavigationBar(){
        title = "Ваше имя"
        navigationItem.leftBarButtonItem = self.navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func addSearchMapButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 8
        saveButton.backgroundColor = Colors.grayDisabled
        buttonContainerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 65))
        nameTextField.inputAccessoryView = buttonContainerView
        buttonContainerView.addSubview(saveButton)
        saveButton.setAnchor(top: buttonContainerView.topAnchor, left: buttonContainerView.leftAnchor,
                             bottom: nil, right: buttonContainerView.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24,height: 50)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func configureTextField(){
        bottomLine.frame = CGRect(x: 0, y: nameTextField.frame.size.height - 1, width: nameTextField.frame.size.width, height: 1)
        bottomLine.backgroundColor = Colors.yassySeperatorGray.cgColor
        nameTextField.borderStyle = .none
        nameTextField.layer.addSublayer(bottomLine)
    }
    
    @objc func saveButtonTapped(){
        if let name = nameTextField.text {
            if !name.isEmpty {
                viewModelInput?.changeName(name: name)
            } else {
                showAlert(alertString: "Введите пожалуйста ваше имя")
            }
        }
    }
    
    @objc func handleEnableButton(_ sender: UITextField){
        switch nameTextField.text {
        case "":
            UIView.animate(withDuration: 0.5){
                self.saveButton.backgroundColor = Colors.grayDisabled
                self.saveButton.isEnabled       = false
                self.bottomLine.backgroundColor = Colors.yassySeperatorGray.cgColor
            }
        default:
            UIView.animate(withDuration: 0.5){
                self.bottomLine.backgroundColor = Colors.newOrange.cgColor
                self.saveButton.isEnabled       = true
                self.saveButton.backgroundColor = Colors.newOrange
               
            }
        }
    }
    

}

extension ChangeUserNameVC: ChangeUserNameViewModelOutput {
    
    func changeNameSuccess() {
        changeCompletion(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func changeNameFailure() {
        showAlert(alertString: "Что то пошло не так")
    }
    
    
}
