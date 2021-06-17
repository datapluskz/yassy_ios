//
//  FavouritesBottomSheetVC.swift
//  Yassy
//
//  Created by Didar Bakhitzhanov on 04.05.2021.
//

import UIKit

protocol FavouritesBottomSheetViewModelInput: AnyObject {
    func searchAddress(address: String)
}

protocol AddAddressSuccessDelegate: AnyObject {
    func addressAddedSuccessfully()
}

protocol AddAddressSuccessDelegateSecond: AnyObject {
    func addressAddedSuccessfullySecond()
}

class FavouritesBottomSheetVC: UIViewController {
    
    lazy var minusButton = UIButton(type: .system)
    lazy var searchTextField = CustomTextFieldWithImage(
        placeHolder: "Укажите адрес", imageName: "ic_search.pdf")
    lazy var buttonContainerView = UIView()
    lazy var searchOnMapButton = SearchOnMapButton()
    lazy var tableView = UITableView(frame: .zero)
    
    var viewModel: FavouritesBottomSheetViewModel
    weak var viewModelInput: FavouritesBottomSheetViewModelInput?
    weak var addressAddedSuccessDelegate: AddAddressSuccessDelegate?
    
    weak var delegate: AddAddressSuccessDelegateSecond?
    
    typealias completion = (Bool) -> Void
    var addressAddedCompletion: completion!
    
    var imageName = String()
    
    init(viewModel: FavouritesBottomSheetViewModel){
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
    }
    
    private func callToViewModelForUIUpdate(){
        viewModel.bindAddressDataToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func setupViews(){
        view.backgroundColor = .white
        configureViews()
        [minusButton, searchTextField, tableView].forEach { (views) in
            view.addSubview(views)
        }
        minusButton.setAnchor(top: view.topAnchor, left: view.leftAnchor,
                              bottom: nil, right: view.rightAnchor,
                              paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, height: 36)
        searchTextField.setAnchor(top: minusButton.bottomAnchor, left: view.leftAnchor,
                                  bottom: nil, right: view.rightAnchor,
                                  paddingTop: 10, paddingLeft: 24, paddingBottom: 0, paddingRight: 24, height: 50)
        tableView.setAnchor(top: searchTextField.bottomAnchor, left: view.leftAnchor,
                            bottom: view.bottomAnchor, right: view.rightAnchor,
                            paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        setupTableView()
        addSearchMapButton()
        
        searchTextField.addTarget(self, action: #selector(textEditingChanged(_:)), for: .editingChanged)
    }
    
    private func configureViews(){
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "minus", withConfiguration: largeConfig)
        minusButton.setImage(largeBoldDoc?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
        searchTextField.setCellShadowTwo()
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .onDrag
    }
    
    private func setupTableView(){
        tableView.register(AddressSuggestsCell.self, forCellReuseIdentifier: "SuggestCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func addSearchMapButton() {
        buttonContainerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 65))
        searchTextField.inputAccessoryView = buttonContainerView
        buttonContainerView.addSubview(searchOnMapButton)
        searchOnMapButton.setAnchor(top: buttonContainerView.topAnchor, left: buttonContainerView.leftAnchor, bottom: nil, right: buttonContainerView.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: 0, paddingRight: 24,height: 50)
        searchOnMapButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    @objc func textEditingChanged(_ sender: UITextField) {
        viewModelInput?.searchAddress(address: sender.text!)
    }
    
    @objc func searchButtonTapped(){
        view.endEditing(true)
        let vc = ChooseAddressOnMapVC(viewModel: ChooseAddressOnMapViewModel(
                                        dataManager: FavouritesDataManager()),
                                      addressType: viewModel.addressType)
        vc.addressAddedCompletion = { [weak self]
            (isSuccess) in
            print("Успещноbottom sehrr")
            self?.addressAddedCompletion(true)
            self?.addressAddedSuccessDelegate?.addressAddedSuccessfully()
            self?.navigationController?.popViewController(animated: false)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getImageName(){
        switch viewModel.addressType {
        case "home":
            imageName = "ic_home"
        case "work":
            imageName = "ic_work"
        case "others":
            imageName = "ic_pin-2"
        default:
            break
        }
    }
    
}

extension FavouritesBottomSheetVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResponseData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "SuggestCell", for: indexPath) as! AddressSuggestsCell
        if let addressData = viewModel.searchResponseData?[indexPath.row] {
            cell.generateCell(addressData)
        }
        return cell
    }
    
    
}

extension FavouritesBottomSheetVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getImageName()
        guard let name = viewModel.searchResponseData?[indexPath.row].value else { return }
        guard let latitude = viewModel.searchResponseData?[indexPath.row].lat else { return }
        guard let longitude = viewModel.searchResponseData?[indexPath.row].lon else { return }
        guard let lat = Double(latitude) else { return }
        guard let lng = Double(longitude) else { return }
        let addressModel = NewAddressModel(address: name, latitude: lat, longitude: lng, type: viewModel.addressType)
        let vc = AddFavouriteAddressVC(viewModel: AddAddressViewModel(
                                        dataManager: FavouritesDataManager(),
                                        newAddressData: addressModel, imageName: imageName))
        vc.addressAddedCompletion = { [weak self]
            (isSuccess) in
            if isSuccess {
                self?.addressAddedCompletion(true)
                self?.delegate?.addressAddedSuccessfullySecond()
                self?.addressAddedSuccessDelegate?.addressAddedSuccessfully()
                self?.navigationController?.popViewController(animated: false)
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
