//
//  ChangeEmailVC.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 04.05.2021.
//


import UIKit

protocol ChangeEmailViewModelInput: AnyObject {
    func changeEmail(name: String)
}

class ChangeEmailVC: UIViewController {
    
    var viewModel: ChangeEmailViewModel
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let emailTextField = CustomTextField(
        placeHolder: "Электронный адрес")
    let bottomLine = CALayer()
    lazy var buttonContainerView = UIView()
    lazy var saveButton = UIButton(type: .system)
    
    weak var viewModelInput: ChangeEmailViewModelInput?
    
    typealias completion = (Bool) -> Void
    var changeCompletion: completion!
    
    init(viewModel: ChangeEmailViewModel){
        self.viewModel = viewModel
        self.viewModelInput = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewModelOutput = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureTextField()
    }
    
    private func setupViews(){
        view.backgroundColor = .white
        setupNavigationBar()
        configureViews()
        addSearchMapButton()
        [titleLabel, descriptionLabel, emailTextField].forEach { (subviews) in
            view.addSubview(subviews)
        }
        titleLabel.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
        descriptionLabel.setAnchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
        emailTextField.setAnchor(top: descriptionLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 28, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
    }
    
    private func setupNavigationBar(){
        title = "Почта"
        navigationItem.leftBarButtonItem = self.navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    
    private func configureViews(){
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.text = "Добавьте почту для отчета"
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .yassyLight
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "На этот адрес мы будем высылать вам отчеты о ваших поездках"
        [titleLabel, descriptionLabel].forEach { (label) in
            label.textAlignment = .left
        }
        emailTextField.delegate = self
    }
    
    private func configureTextField(){
        bottomLine.frame = CGRect(x: 0, y: emailTextField.frame.size.height - 1, width: emailTextField.frame.size.width, height: 1)
        bottomLine.backgroundColor = Colors.yassySeperatorGray.cgColor
        emailTextField.borderStyle = .none
        emailTextField.layer.addSublayer(bottomLine)
    }
    
    private func addSearchMapButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 8
        saveButton.backgroundColor = Colors.grayDisabled
        buttonContainerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 65))
        emailTextField.inputAccessoryView = buttonContainerView
        buttonContainerView.addSubview(saveButton)
        saveButton.setAnchor(top: buttonContainerView.topAnchor, left: buttonContainerView.leftAnchor,
                             bottom: nil, right: buttonContainerView.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24,height: 50)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    @objc func saveButtonTapped(){
        guard let emailText = emailTextField.text else { return }
        if isValidEmail(email: emailText) == false {
            showAlert(alertString: "Пожалуйста введите правильную элетронную почту")
        } else {
            viewModelInput?.changeEmail(name: emailText)
        }
    }
    
    private func isValidEmail(email: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

}

extension ChangeEmailVC: ChangeEmailViewModelOutput {
    func changeEmailSuccess() {
        changeCompletion(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    func changeEmailFailure() {
        showAlert(alertString: "Что то пошло не так")
    }
    
    
}

extension ChangeEmailVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        textField.text = (textField.text! as NSString).replacingCharacters(in: range, with: string.lowercased())
        switch emailTextField.text {
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
        return false
    }
}
