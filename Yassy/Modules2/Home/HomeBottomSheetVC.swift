//
//  HomeBottomSheetVC.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 03.05.2021.
//

import UIKit

protocol HomeBottomSheetViewModelInput: AnyObject {
    func searchAddress(address: String)
}

protocol BottomSheetHideProtocol: AnyObject {
    func hideBottomSheet(tag: Int, address: String, latitude: String, longitude: String)
    func addHomeTapped()
    func addWorkTapped()
}

protocol FavouritesAndHomeBottomSheetProtocol: AnyObject {
    func presentHome()
    func presentWork()
}

class HomeBottomSheetVC: UIViewController {
    
    lazy var minusButton = UIButton(type: .system)
    
    lazy var userLocationButton = UIButton(type: .system)
    lazy var sosButton = UIButton(type: .system)
    
    lazy var textFieldsContainerView = UIView()
    lazy var userLocationTextField = UITextField()
    lazy var searchTextField = UITextField()
    lazy var searchOnMap = UIButton()
    
    lazy var addHomeButton = UIButton()
    lazy var addJobeButton = UIButton()
    var check: ((Bool) -> ())?
    var getAddress: ((Bool, String) -> ())?
    
    weak var delegate: FavouritesAndHomeBottomSheetProtocol?
    
    lazy var stackButton: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [
            addHomeButton,
            addJobeButton
        ])
        sv.axis = .horizontal
        sv.spacing = 8
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var tableView = UITableView(frame: .zero)
    
    let favouriteModel = [Model(title: HOME_BUTTON_TEXT, imageName: "home"),
                          Model(title: JOBE_BUTTON_TEXT, imageName: "job")]
    
    var viewModel: HomeBottomSheetViewModel
    
    weak var viewModelInput: HomeBottomSheetViewModelInput?
    weak var hideDelegate: BottomSheetHideProtocol?
    
    var currentTextFieldTag = Int()
  
    
    init(viewModel: HomeBottomSheetViewModel) {
        self.viewModel = viewModel
        self.viewModelInput = self.viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        callToViewModelForUIUpdate()
        addSearchMapButton()
    }
    
    
    fileprivate func setupViews(){
        configureViews()
        
        [minusButton, userLocationButton, sosButton , textFieldsContainerView, stackButton, tableView].forEach{
            view.addSubview($0)
        }
        
        [userLocationTextField, searchTextField].forEach{
            textFieldsContainerView.addSubview($0)
        }
        
        minusButton.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 36)
        
        userLocationButton.setAnchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 24, width: 40, height: 40)
        
        sosButton.setAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        textFieldsContainerView.setAnchor(top: minusButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 100)
        
        userLocationTextField.setAnchor(top: textFieldsContainerView.topAnchor, left: textFieldsContainerView.leftAnchor, bottom: nil, right: textFieldsContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50)
        
        searchTextField.setAnchor(top: userLocationTextField.bottomAnchor, left: textFieldsContainerView.leftAnchor, bottom: nil, right: textFieldsContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 50)
        
        stackButton.setAnchor(top: textFieldsContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 10, paddingLeft: 24, paddingBottom: 0, paddingRight: 24)
        
        tableView.setAnchor(top: textFieldsContainerView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        minusButton.isHidden = true
        tableView.isHidden = true
        
        setupTableView()
    }
    
    
    private func configureViews(){
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "minus", withConfiguration: largeConfig)
        minusButton.setImage(largeBoldDoc?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
        
        userLocationButton.setImage(#imageLiteral(resourceName: "ic_main").withRenderingMode(.alwaysOriginal), for: .normal)
        
        sosButton.setTitle("SOS", for: .normal)
        sosButton.setTitleColor(.yassyOrange, for: .normal)
        sosButton.titleLabel?.font = .boldSystemFont(ofSize: 14)
        
        [userLocationButton, textFieldsContainerView, sosButton].forEach{
            $0.backgroundColor = .white
            $0.shadowView()
            $0.layer.cornerRadius = 8
        }
        
        [addHomeButton, addJobeButton].forEach { (btn) in
            btn.titleLabel?.font = .systemFont(ofSize: 14)
        }
        
        userLocationTextField.setupLeftImageToTextField(imageName: "point.pdf")
        searchTextField.setupLeftImageToTextField(imageName: "ic_search.pdf")
        
        userLocationTextField.placeholder = "Ваше местоположение"
        searchTextField.placeholder = "Куда поедете?"
        userLocationTextField.tag = 1
        searchTextField.tag = 2
        
        [userLocationTextField, searchTextField].forEach { (txt) in
            txt.clearButtonMode = .whileEditing
        }
        
        let homeAddress = HomeAddressDefaults.getHomeAddressData().homeAddress
        if homeAddress.isEmpty {
            addHomeButton.configureButton(title: HOME_BUTTON_TEXT, titleColor: .black, isEnabled: true, cornerRadius: 9, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 37, backgroundColor: .white)
        } else {
            addHomeButton.configureButton(title: "Домой", titleColor: .black, isEnabled: true, cornerRadius: 9, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 37, backgroundColor: .white)
        }
        
        let workAddress = WorkAddressDefaults.getWorkAddressData().workAddress
        if workAddress.isEmpty {
            addJobeButton.configureButton(title: JOBE_BUTTON_TEXT, titleColor: .black, isEnabled: true, cornerRadius: 9, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 37, backgroundColor: .white)
        } else {
            addJobeButton.configureButton(title: "На работу", titleColor: .black, isEnabled: true, cornerRadius: 9, borderWidth: 0, borderColor: UIColor.clear.cgColor, height: 37, backgroundColor: .white)
        }
       
        addHomeButton.buttonLeftImageee(image: #imageLiteral(resourceName: "home"), renderMode: .alwaysOriginal)
        addHomeButton.buttonTitlePadding(top: 0, left: 20, bottom: 0, right: 0)
       
        addJobeButton.buttonTitlePadding(top: 0, left: 20, bottom: 0, right: 0)
        addJobeButton.buttonLeftImageee(image: #imageLiteral(resourceName: "job"), renderMode: .alwaysOriginal)
        
        addHomeButton.shadowView()
        addJobeButton.shadowView()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        userLocationTextField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
        searchTextField.addTarget(self, action: #selector(textSecondEditingChanged(_:)), for: .editingChanged)
        
        addHomeButton.addTarget(self, action: #selector(addHomeButtonTapped), for: .touchUpInside)
        addJobeButton.addTarget(self, action: #selector(addWorkButtonTapped), for: .touchUpInside)
    }
    
    private func setupTableView(){
        [AddFavouriteAddressCell.self, AddressSuggestsCell.self].forEach { (cell) in
            tableView.register(cell, forCellReuseIdentifier: cell.description())
        }
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func callToViewModelForUIUpdate(){
        viewModel.bindAddressDataToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func addSearchMapButton() {
        searchOnMap = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        searchOnMap.backgroundColor = .white
        searchOnMap.setTitle("Указать на карте", for: .normal)
        searchOnMap.setTitleColor(.yassyOrange, for: .normal)
        searchOnMap.shadowView()
        searchTextField.inputAccessoryView = searchOnMap
        searchOnMap.addTarget(self, action: #selector(handleHide), for: .touchUpInside)
    }
    
    @objc fileprivate func handleHide() {
        check?(true)
    }
    
    @objc func textEditingChanged(_ sender: UITextField) {
        currentTextFieldTag = sender.tag
        viewModelInput?.searchAddress(address: sender.text!)
    }
    
    @objc func textSecondEditingChanged(_ sender: UITextField){
        currentTextFieldTag = sender.tag
        viewModelInput?.searchAddress(address: sender.text!)
    }
    
    @objc func addHomeButtonTapped(){
        let dataDefaults = HomeAddressDefaults.getHomeAddressData()
        let address = dataDefaults.homeAddress
        let latitude = Double(dataDefaults.homeLatitude)
        let longitude = Double(dataDefaults.homeLongitude)

        searchTextField.text = address
        
        AddressInformation.d_address = address
        AddressInformation.d_lat = latitude ?? 0.0
        AddressInformation.d_lon = longitude ?? 0.0
        
        hideDelegate?.addHomeTapped()
        
        if address == "" {
            delegate?.presentHome()
            presentFavouritesPage()
        }
    }
    
    @objc func addWorkButtonTapped(){
        let dataDefaults = WorkAddressDefaults.getWorkAddressData()
        let address = dataDefaults.workAddress
        let latitude = Double(dataDefaults.workLatitude)
        let longitude = Double(dataDefaults.workLongitude)
        searchTextField.text = address
        
        AddressInformation.d_address = address
        AddressInformation.d_lat = latitude ?? 0.0
        AddressInformation.d_lon = longitude ?? 0.0
        
        hideDelegate?.addWorkTapped()
        
        if address == "" {
            delegate?.presentWork()
            presentFavouritesPage()
        }
    }
    
    private func presentFavouritesPage(){
        let vc = FavouritesVC(viewModel: FavouritesViewModel(dataManager: FavouritesDataManager()))
        self.delegate = vc
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
//        nav.modalTransitionStyle = .crossDissolve
        self.present(nav, animated: true, completion: nil)
    }
    
}

extension HomeBottomSheetVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return favouriteModel.count
        default:
            return viewModel.searchResponseData?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddFavouriteAddressCell.description(), for: indexPath) as! AddFavouriteAddressCell
            cell.generateCell(favouriteModel[indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: AddressSuggestsCell.description(), for: indexPath) as! AddressSuggestsCell
            if let addressData = viewModel.searchResponseData?[indexPath.row] {
                cell.generateCell(addressData)
            }
            return cell
        }
    }
    
    
}

extension HomeBottomSheetVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let dataDefaults = HomeAddressDefaults.getHomeAddressData()
                let address = dataDefaults.homeAddress
                let latitude = Double(dataDefaults.homeLatitude)
                let longitude = Double(dataDefaults.homeLongitude)
                searchTextField.text = address
                
                AddressInformation.d_address = address
                AddressInformation.d_lat = latitude ?? 0.0
                AddressInformation.d_lon = longitude ?? 0.0
                
                hideDelegate?.addHomeTapped()
                if address == "" {
                    delegate?.presentHome()
                    presentFavouritesPage()
                }
            }
            
            if indexPath.row == 1 {
                let dataDefaults = WorkAddressDefaults.getWorkAddressData()
                let address = dataDefaults.workAddress
                let latitude = Double(dataDefaults.workLatitude)
                let longitude = Double(dataDefaults.workLongitude)
                searchTextField.text = address
                
                AddressInformation.d_address = address
                AddressInformation.d_lat = latitude ?? 0.0
                AddressInformation.d_lon = longitude ?? 0.0
                
                hideDelegate?.addWorkTapped()
                if address == "" {
                    delegate?.presentWork()
                    presentFavouritesPage()
                }
            }
        }
        
        
        if indexPath.section == 1 {
            
            //MARK: - Каждый текстфилдка бирыншы tag берып койдым , textEditingChanged та кай текстфилд колданылып жатканын сохраняет
            
            if let addressData = viewModel.searchResponseData?[indexPath.row] {
                if currentTextFieldTag == 1 {
                    userLocationTextField.text = addressData.value
                    viewModel.searchResponseData?.removeAll()
                    hideDelegate?.hideBottomSheet(tag: currentTextFieldTag, address: addressData.value ?? "Не определен", latitude: addressData.lat ?? "0.0", longitude: addressData.lon ?? "0.0")
                }
                
                if currentTextFieldTag == 2 {
                    searchTextField.text = addressData.value
                    viewModel.searchResponseData?.removeAll()
                    hideDelegate?.hideBottomSheet(tag: currentTextFieldTag, address: addressData.value ?? "Не определен", latitude: addressData.lat ?? "0.0", longitude: addressData.lon ?? "0.0")
                }
            }
        }
    }
}
