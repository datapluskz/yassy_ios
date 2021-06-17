//
//  CloseViewController.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 05.05.2021.
//
import UIKit

struct CloseID {
    static var closeID = Int()
}

class CloseViewController: UIViewController {
    
    lazy var backButton = UIButton()
    lazy var closeTitle = UILabel()
    let CLOSE_TB_ID = "CLOSETBID"
    
    let closeTableView: UITableView = {
        let tb = UITableView(frame: .zero, style: .grouped)
        return tb
    }()
    
    var firstButton = UIButton(type: .system)
    var secondButton = UIButton(type: .system)
    var thirdButton = UIButton(type: .system)
    var fourthButton = UIButton(type: .system)
    var fifthButton = UIButton(type: .system)
    
    lazy var firstLabel = UILabel()
    lazy var secondLabel = UILabel()
    lazy var thirdLabel = UILabel()
    lazy var fourthLabal = UILabel()
    lazy var fifthLabel = UILabel()
    
    lazy var reseons = String()
    lazy var requestID = String()
    
    var firstCheck = 0
    var secendCheck = 0
    var thirdCheck = 0
    var fourthCheck = 0
    var fifthCheck = 0
    
    lazy var sendButton = UIButton(type: .system)
    
    lazy var starckFirst: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            firstButton,
            firstLabel
        ])
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    lazy var stackSecond: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            firstButton,
            firstLabel
        ])
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    lazy var stackThird: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            secondButton,
            secondLabel
        ])
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    lazy var stackFourth: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            fourthButton,
            firstLabel
        ])
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    lazy var stackFifth: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            fifthButton,
            fifthLabel
        ])
        sv.axis = .horizontal
        sv.spacing = 8
        return sv
    }()
    
    let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        updateView()
        print("HELLLLLOOOOOOOOOOOOOOOOW\(requestID)")
    }
    
    fileprivate func configureView() {
        setupView()
        view.backgroundColor = .white
        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
    }
    
    private func setupView() {
        positionLayouts()
        backButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 8, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .white)
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        backButton.setImage(#imageLiteral(resourceName: "ic_back"), for: .normal)
        backButton.shadowView()
        
        closeTitle.configureLabel(text: "Причины отмены", textColor: .black, textAlignment: .center, fontName: "", fontSize: 0, numberOfLines: 0)
        [firstButton, secondButton, thirdButton, fourthButton, fifthButton].forEach { image in
            image.setImage(#imageLiteral(resourceName: "Ellipse 5").withRenderingMode(.alwaysOriginal), for: .normal)
        }
        if firstButton.isSelected {
            firstButton.setImage(#imageLiteral(resourceName: "true-1").withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        if secondButton.isSelected {
            secondButton.setImage(#imageLiteral(resourceName: "true-1").withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        if thirdButton.isSelected {
            thirdButton.setImage(#imageLiteral(resourceName: "true-1").withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        if fourthButton.isSelected {
            fourthButton.setImage(#imageLiteral(resourceName: "true-1").withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        if fifthButton.isSelected {
            fifthButton.setImage(#imageLiteral(resourceName: "true-1").withRenderingMode(.alwaysOriginal), for: .normal)
        }
        
        firstButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .clear)
        secondButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .clear)
        thirdButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .clear)
        fourthButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .clear)
        fifthButton.configureButton(title: "", titleColor: .clear, isEnabled: true, cornerRadius: 0, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .clear)
        
        [firstButton, secondButton, thirdButton, fourthButton, fifthButton].forEach { width in
            width.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        firstLabel.configureLabel(text: "Передумал", textColor: .black, textAlignment: .natural, fontName: "", fontSize: 12, numberOfLines: 0)
        secondLabel.configureLabel(text: "Водитель не двигался", textColor: .black, textAlignment: .natural, fontName: "", fontSize: 12, numberOfLines: 0)
        thirdLabel.configureLabel(text: "Слишком долго ждал", textColor: .black, textAlignment: .natural, fontName: "", fontSize: 12, numberOfLines: 0)
        fourthLabal.configureLabel(text: "Водитель не туда уехал", textColor: .black, textAlignment: .natural, fontName: "", fontSize: 12, numberOfLines: 0)
        fifthLabel.configureLabel(text: "Помолка транспорта", textColor: .black, textAlignment: .natural, fontName: "", fontSize: 12, numberOfLines: 0)
        sendButton.configureButton(title: "Отправить", titleColor: .white, isEnabled: true, cornerRadius: 12, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 50, backgroundColor: .yassyOrange)
    }
    
    private func positionLayouts() {
        [backButton, closeTitle, firstButton, secondButton, thirdButton, fourthButton, fifthButton, firstLabel, secondLabel, thirdLabel, fourthLabal, fifthLabel, sendButton].forEach {
            view.addSubview($0)
        }
        
        backButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        closeTitle.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 50, left: 0, bottom: 0, right: 0))
        closeTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        firstButton.anchor(top: backButton.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 20, left: 20, bottom: 0, right: 0))
        secondButton.anchor(top: firstButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 20, bottom: 0, right: 0))
        thirdButton.anchor(top: secondButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 20, bottom: 0, right: 0))
        fourthButton.anchor(top: thirdButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 20, bottom: 0, right: 0))
        fifthButton.anchor(top: fourthButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 12, left: 20, bottom: 0, right: 0))
        
        firstLabel.anchor(top: nil, leading: firstButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        secondLabel.anchor(top: nil, leading: secondButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        thirdLabel.anchor(top: nil, leading: thirdButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        fourthLabal.anchor(top: nil, leading: fourthButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        fifthLabel.anchor(top: nil, leading: fifthButton.trailingAnchor, bottom: nil, trailing: nil, padding: .init(top: 0, left: 12, bottom: 0, right: 0))
        
        firstLabel.centerYAnchor.constraint(equalTo: firstButton.centerYAnchor).isActive = true
        secondLabel.centerYAnchor.constraint(equalTo: secondButton.centerYAnchor).isActive = true
        thirdLabel.centerYAnchor.constraint(equalTo: thirdButton.centerYAnchor).isActive = true
        fourthLabal.centerYAnchor.constraint(equalTo: fourthButton.centerYAnchor).isActive = true
        fifthLabel.centerYAnchor.constraint(equalTo: fifthButton.centerYAnchor).isActive = true
        
        
        firstButton.addTarget(self, action: #selector(firstTarget), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(secondTarget), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(thirdTarget), for: .touchUpInside)
        fourthButton.addTarget(self, action: #selector(fourthTarget), for: .touchUpInside)
        fifthButton.addTarget(self, action: #selector(fifthTarget), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(handleSendView), for: .touchUpInside)
        
        sendButton.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 32, bottom: 30, right: 32))
        
//        closeTableView.anchor(top: backButton.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0))
//        closeTableView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    /// targets
    @objc fileprivate func firstTarget() {
        firstCheck = firstCheck + 1
        if firstCheck%2 == 0 {
            UIView.animate(withDuration: 0.5) { [self] in
                firstButton.setImage(#imageLiteral(resourceName: "Ellipse 5").withRenderingMode(.alwaysOriginal), for: .normal)
                firstButton.layoutIfNeeded()
                firstCheck += 1
            }
        } else {
            UIView.animate(withDuration: 0.5) { [self] in
                firstButton.setImage(#imageLiteral(resourceName: "true-1").withRenderingMode(.alwaysOriginal), for: .normal)
                firstButton.layoutIfNeeded()
                firstCheck += 1
            }
        }
        
        print(firstCheck = firstCheck + 1)
    }
    
    @objc fileprivate func secondTarget() {
        secendCheck = secendCheck + 1
        if secendCheck%2 == 0 {
            UIView.animate(withDuration: 0.5) { [self] in
                secondButton.setImage(#imageLiteral(resourceName: "Ellipse 5").withRenderingMode(.alwaysOriginal), for: .normal)
                secondButton.layoutIfNeeded()
                secendCheck += 1
            }
        } else {
            UIView.animate(withDuration: 0.5) { [self] in
                secondButton.setImage(#imageLiteral(resourceName: "true-1").withRenderingMode(.alwaysOriginal), for: .normal)
                secondButton.layoutIfNeeded()
                secendCheck += 1
            }
        }
    }
    
    @objc fileprivate func thirdTarget() {
        thirdCheck = thirdCheck + 1
        if thirdCheck%2 == 0 {
            UIView.animate(withDuration: 0.5) { [self] in
                thirdButton.setImage(#imageLiteral(resourceName: "Ellipse 5").withRenderingMode(.alwaysOriginal), for: .normal)
                thirdButton.layoutIfNeeded()
                thirdCheck += 1
            }
        } else {
            UIView.animate(withDuration: 0.5) { [self] in
                thirdButton.setImage(#imageLiteral(resourceName: "true-1").withRenderingMode(.alwaysOriginal), for: .normal)
                thirdButton.layoutIfNeeded()
                thirdCheck += 1
            }
        }
    }
    
    @objc fileprivate func fourthTarget() {
        fourthCheck = fourthCheck + 1
        if fourthCheck%2 == 0 {
            UIView.animate(withDuration: 0.5) { [self] in
                fourthButton.setImage(#imageLiteral(resourceName: "Ellipse 5").withRenderingMode(.alwaysOriginal), for: .normal)
                fourthButton.layoutIfNeeded()
                fourthCheck += 1
            }
        } else {
            UIView.animate(withDuration: 0.5) { [self] in
                fourthButton.setImage(#imageLiteral(resourceName: "true-1").withRenderingMode(.alwaysOriginal), for: .normal)
                fourthButton.layoutIfNeeded()
                fourthCheck += 1
            }
        }
    }
    
    @objc fileprivate func fifthTarget() {
        fifthCheck = fifthCheck + 1
        if fifthCheck%2 == 0 {
            UIView.animate(withDuration: 0.5) { [self] in
                fifthButton.setImage(#imageLiteral(resourceName: "Ellipse 5").withRenderingMode(.alwaysOriginal), for: .normal)
                fifthButton.layoutIfNeeded()
                fifthCheck += 1
            }
        } else {
            UIView.animate(withDuration: 0.5) { [self] in
                fifthButton.setImage(#imageLiteral(resourceName: "true-1").withRenderingMode(.alwaysOriginal), for: .normal)
                fifthButton.layoutIfNeeded()
                fifthCheck += 1
            }
        }
    }
    
    @objc fileprivate func handleSendView() {
        setupLoading(timer: 1, centerY: 0)
        viewModel.closeEnd(id: "\(CloseID.closeID)", reseon: reseons) {
            print("RequestID\(CloseID.closeID)")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [unowned self] in
            let vc = UINavigationController(rootViewController: HomeVC(viewModel: HomeViewModel(dataManager: DataManager()), addressViewModel: MainViewModel(dataManager: DataManager()), lat: 0.0, lng: 0.0))
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    fileprivate func updateView() {
        viewModel.closeOne { [unowned self] in
            guard let reseon = viewModel.closeOne.last?.reason else { return }
            print("TEEEEEEEEEES\(reseon)")
            reseons.append(reseon)
        }
    }
    
//    private func setupTableView() {
//        closeTableView.delegate = self
//        closeTableView.dataSource = self
//        closeTableView.register(CloseTableViewCell.self, forCellReuseIdentifier: CLOSE_TB_ID)
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
