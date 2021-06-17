//
//  ChooseAddressOnMapVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 10.05.2021.
//

import UIKit
import Mapbox

protocol ChooseAddressOnMapViewModelInput: AnyObject {
    func searchAddressByCoordinates(lat: Double, lon: Double)
}

class ChooseAddressOnMapVC: UIViewController {
    
    lazy var url = URL(string: "mapbox://styles/mapbox/streets-v11")
    lazy var mapView = MGLMapView(frame: view.bounds, styleURL: url)
    let marker = UIImageView(image: #imageLiteral(resourceName: "ic_pin").withRenderingMode(.alwaysOriginal))
    lazy var addressLabel = UILabel()
    lazy var chooseButton = UIButton(type: .system)
    
    var checkMap = false
    var viewModel: ChooseAddressOnMapViewModel
    var addressType: String
    weak var viewModelInput: ChooseAddressOnMapViewModelInput?
    var imageName = String()
    
    typealias completion = (Bool) -> Void
    var addressAddedCompletion: completion!
    
    
    init(viewModel: ChooseAddressOnMapViewModel, addressType: String){
        self.viewModel = viewModel
        self.addressType = addressType
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
    
    fileprivate func setupViews(){
        getImageName()
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = self.navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.logoView.isHidden = true
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        addMarker()
        addAddressLabel()
        addChooseButton()
    }
    
    private func addMarker() {
        mapView.addSubview(marker)
        marker.center = mapView.center
        marker.shadowView()
    }
    
    private func addAddressLabel(){
        addressLabel.textAlignment = .center
        addressLabel.numberOfLines = 0
        mapView.addSubview(addressLabel)
        addressLabel.setAnchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor,
                               bottom: nil, right: view.rightAnchor,
                               paddingTop: 8, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
    }
    
    private func getImageName(){
        switch addressType {
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
    
    private func addChooseButton(){
        chooseButton.backgroundColor = .yassyOrange
        chooseButton.layer.cornerRadius = 8
        chooseButton.setTitleColor(.white, for: .normal)
        chooseButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        chooseButton.setTitle("Подтвердить", for: .normal)
        chooseButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        chooseButton.addTarget(self, action: #selector(chooseButtonTapped), for: .touchUpInside)
        mapView.addSubview(chooseButton)
        chooseButton.setAnchor(top: nil, left: mapView.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: mapView.rightAnchor, paddingTop: 0, paddingLeft: 24, paddingBottom: -16, paddingRight: 24)
    }
    
    private func callToViewModelForUIUpdate(){
        viewModel.bindAddressStringToController = {
            DispatchQueue.main.async {
                self.addressLabel.text = self.viewModel.addressStringData?.name
            }
        }
    }
    
    @objc func chooseButtonTapped(){
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        let addressModel = NewAddressModel(address: viewModel.addressStringData?.name ?? "",
                                           latitude: latitude, longitude: longitude, type: addressType)
        let vc = AddFavouriteAddressVC(viewModel: AddAddressViewModel(
                                        dataManager: FavouritesDataManager(),
                                        newAddressData: addressModel, imageName: imageName))
        vc.addressAddedCompletion = { [weak self]
            (isSuccess) in
            if isSuccess {
                print("Успещно Choose address on map")
                self?.addressAddedCompletion(true)
                self?.navigationController?.popViewController(animated: false)
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    
}

extension ChooseAddressOnMapVC: MGLMapViewDelegate {
    func mapViewRegionIsChanging(_ mapView: MGLMapView) {
        checkMap = true
    }
    
    func mapView(_ mapView: MGLMapView, regionDidChangeWith reason: MGLCameraChangeReason, animated: Bool) {
        if checkMap {
            let latitude = mapView.centerCoordinate.latitude
            let longitude = mapView.centerCoordinate.longitude
            viewModelInput?.searchAddressByCoordinates(lat: latitude, lon: longitude)
        }
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        if let userLocation = mapView.userLocation?.location?.coordinate {
            let coordinate = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
            mapView.setCenter(coordinate, zoomLevel: 15, animated: false)
        } else {
            showAlert(alertString: "Включите геолокацию")
            mapView.setCenter(AppKeys.turkestanCoordinate, zoomLevel: 15, animated: false)
        }
    }
}
