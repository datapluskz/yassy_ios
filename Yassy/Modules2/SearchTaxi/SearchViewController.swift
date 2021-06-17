//
//  SearchViewController.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 29.04.2021.
//

import UIKit
import FloatingPanel
import Mapbox
import MapboxNavigation
import MapboxCoreNavigation
import MapboxDirections

struct ProviderLocation {
    static var s_lat = Double()
    static var s_lon = Double()
}

struct RequestID {
    static var requestID = Int()
    static var reaseon = String()
    static var provider_lat = Double()
}

class SearchViewController: UIViewController, FloatingPanelControllerDelegate, MGLMapViewDelegate {
    
    // MARK: - Properties
    var viewModel: MainViewModel!
    var check = true
    lazy var distance = String()
    lazy var mapView = MGLMapView(frame: view.bounds)
    var dataManager: DataManager!
    var viewmodel: MainViewModel!
    var checks = true
    var checkAnimationString = String()
    var checkState = [Int]()
    var timer = Timer()
    var carTimer = Timer()
    var searchingState = true
    var startedState = true
    var complatedState = true
    var arrivedState = true
    var ratingView = RatingView()
    var endedView = EndedView()
    var pulseView = SomeAwesomeView()
    var pulseCheck: Bool
    var reseon = Int()
    var searchView = SearchView()
    var testView = UIView()
    var drawRoute: ((Bool) -> ())?
    var isEmtyString = String()
    var carIsMoving: ((Bool) -> ())?
    var isDrowLine: ((Bool) -> ())?
    var showDetailView: ((Bool) -> ())?
    var provider_lat = Double()
    var provider_lon = Double()
    var sizeScreen = UIScreen.main.bounds.height
    var isDrawCar: ((Bool) -> ())?
    var fpc: FloatingPanelController!
    lazy var contentVC = SearchTaxiFloatingPanel()
    var checkIf = true
    var workingDriver = true
    var workingCallBack: ((Bool) -> ())?
    var deletedCell: ((Bool) -> ())?
    lazy var requestID = String()
    var positionCamera = true
    
    var routeOptions: NavigationRouteOptions?
    var route: Route?
    /// for drowLineWhenStarted
    var drowIsCheck: ((Bool)->())?
    
    init(dataManager: DataManager, viewmodel: MainViewModel, pulseCheck: Bool) {
        self.dataManager = dataManager
        self.pulseCheck = pulseCheck
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(checkStatus), userInfo: nil, repeats: true)
        carTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(checkCar), userInfo: nil, repeats: true)
        setupAction()
        showMapBox()
        animatedPulseView()
        setupView()
        configureView()
        configureFloatingPanel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print(checkState)
    }
    
    private func animatedPulseView() {
        view.addSubview(pulseView)
        pulseView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil)
        pulseView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 8).isActive = true
        pulseView.heightAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        pulseView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        pulseView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    @objc func checkStatus() {
        viewmodel.statusCheck { [self] check in
            let status = self.viewmodel.dataStatus?.data?.status
            let id = viewmodel.dataStatus?.data?.id
            //let vc = StartedViewController(viewModel: MainViewModel(dataManager: DataManager()))
            //vc.lat?(viewModel.dataStatus?.data?.provider_latitude ?? 0.0)
            RequestID.requestID = id ?? 0
            print("TestTest\(check)")
            
            print("IDDDDDDD\(String(describing: id))")
            if status == "STARTED" {
                provider_lat = viewmodel.dataStatus?.data?.provider_latitude ?? 0.0
                provider_lon = viewmodel.dataStatus?.data?.provider_longitude ?? 0.0
                CloseID.closeID = viewmodel.dataStatus?.data?.id ?? 0
                print("PROVIDER")
                if startedState {
                    isDrawCar?(true)
                    drawRoute?(true)
                    DetailItems.driverName = "\(viewmodel.dataStatus?.data?.provider_first_name ?? "firstName isEmty") \(viewmodel.dataStatus?.data?.provider_last_name ?? "lastNameIsEmty")"
                    DetailItems.car = "\(viewmodel.dataStatus?.data?.provider_service_car ?? "name is Car Emty") \(viewmodel.dataStatus?.data?.provider_service_number ?? "Provider number is Emty")"
                    DetailItems.phoneNumber = viewmodel.dataStatus?.data?.provider_number ?? "Provider Number Is Emty"
                    contentVC.carMarkLabel.text = "\(viewmodel.dataStatus?.data?.provider_service_car ?? "name is Car Emty") \(viewmodel.dataStatus?.data?.provider_service_number ?? "Provider number is Emty")"
                    pulseView.alpha = 0
                    searchView.alpha = 0
                    contentVC.callButton.addTarget(self, action: #selector(handleCallDriver), for: .touchUpInside)
                    contentVC.isgoButton.addTarget(self, action: #selector(showAlerIsGo), for: .touchUpInside)
                    contentVC.view.layoutIfNeeded()
                    view.layoutIfNeeded()
                    fpc.move(to: .half, animated: true)
                }
                startedState = false
            }
            
            if status == "ARRIVED" {
                if arrivedState {
                    UIView.animate(withDuration: 0.5) { [self] in
                        fpc.hide(animated: true, completion: nil)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            fpc.move(to: .half, animated: true)
                            contentVC.isgoButton.tintColor = .yassyOrange
                            contentVC.isgoButton.isEnabled = true
                            contentVC.isgoButton.addTarget(self, action: #selector(handleGoTaxi), for: .touchUpInside)
                            contentVC.timeLabel.text = "Водитель прибыл"
                            contentVC.messageButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
                            contentVC.messageButton.badge = "1"
                            contentVC.timeLabel.layoutIfNeeded()
                        }
                    }
                }
                arrivedState = false
            }
            
            if status == "PICKEDUP" {
                if workingDriver {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        fpc.hide(animated: true, completion: nil)
                        deletedCell?(true)
                        contentVC.startedTableView.removeFromSuperview()
                        contentVC.stackButton.removeFromSuperview()
                        contentVC.closeButton.removeFromSuperview()
                        contentVC.addAddressButton.removeFromSuperview()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        fpc.move(to: .startState, animated: true)
                        contentVC.view.addSubview(contentVC.startedTableView)
                        contentVC.startedTableView.anchor(top: contentVC.stackLabel.bottomAnchor, leading: contentVC.view.leadingAnchor, bottom: nil, trailing: contentVC.view.trailingAnchor)
                        UIView.animate(withDuration: 1) {
                            contentVC.carMarkLabel.text = "По окончанию поездки, пожалуйста не\n забудьте поставить оценку."
                            contentVC.timeLabel.text = "Осталось 20 минут"
                            workingCallBack?(true)
                            //contentVC.view.layoutIfNeeded()
                        }
                    }
                }
                workingDriver = false
            }
            
            if status == "COMPLETED" {
                if complatedState {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        fpc.hide(animated: true, completion: nil)
                        contentVC.startedTableView.removeFromSuperview()
                        contentVC.stackButton.removeFromSuperview()
                        contentVC.closeButton.removeFromSuperview()
                        contentVC.addAddressButton.removeFromSuperview()
                        contentVC.stackLabel.removeFromSuperview()
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    fpc.move(to: .startState, animated: true)
                    contentVC.view.addSubview(ratingView)
                    ratingView.anchor(top: contentVC.view.topAnchor, leading: contentVC.view.leadingAnchor, bottom: contentVC.view.bottomAnchor, trailing: contentVC.view.trailingAnchor)
                }
                
                complatedState = false
            }
        }
    }
    
    func setupAction() {
        contentVC.closeButton.addTarget(self, action: #selector(handleClose), for: .touchUpInside)
        ratingView.finishButton.addTarget(self, action: #selector(sendRating), for: .touchUpInside)
    }
    
    func configureFloatingPanel() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        fpc.set(contentViewController: contentVC)
        fpc.addPanel(toParent: self)
        fpc.layout = SearchFpcLayout()
        fpc.hide()
    }
    
    @objc fileprivate func handleShowCheck() {
        let vc = HomeVC(viewModel: HomeViewModel(dataManager: DataManager()), addressViewModel: MainViewModel(dataManager: DataManager()), lat: 0.0, lng: 0.0)
        vc.view.addSubview(endedView)
        let size = vc.view
        endedView.anchor(top: size?.topAnchor, leading: size?.leadingAnchor, bottom: size?.bottomAnchor, trailing: size?.trailingAnchor)
    }
    
    @objc fileprivate func showAlerIsGo() {
        showAlert(alertString: "Водитель \(DetailItems.driverName) ждет вас")
    }
    
    @objc fileprivate func sendRating() {
        viewmodel.raiting(requestID: "\(RequestID.requestID)") {
            print("TESSSSSSSSTTTTTTTTTT")
            let vc = CheckViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc fileprivate func handleCallDriver() {
        callNumber(phoneNumber: DetailItems.phoneNumber)
    }
    
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://+7\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @objc fileprivate func handleClose() {
        closeAlert(string: requestID)
        timer.invalidate()
    }
    
    fileprivate func configureView() {
        view.backgroundColor = .white
        configureNavigationBar(isHidden: true, backgroundColor: .clear, title: "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    fileprivate func setupView() {
        view.addSubview(searchView)
        searchView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0))
        searchView.closeButton.addTarget(self, action: #selector(handleShowOrderView), for: .touchUpInside)
    }
    
    @objc fileprivate func handleShowOrderView() {
        closeAlertWhenSearch()
    }
    
    private func showMapBox() {
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        mapView.setCenter(CLLocationCoordinate2D(latitude: AddressInformation.s_lat, longitude: AddressInformation.s_lon), zoomLevel: 16, animated: false)
        view.addSubview(mapView)
    }
    
    @objc fileprivate func checkCar() {
        print("PROVIDER-LAT\(String(describing: provider_lat))")
        carIsMoving?(true)
        isDrowLine?(true)
    }
    
    @objc fileprivate func handleGoTaxi() {
        print("GOGOGO")
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        let startPoint = MGLPointAnnotation()
        startPoint.coordinate = CLLocationCoordinate2D(latitude: AddressInformation.s_lat, longitude: AddressInformation.s_lon)
            
        let shapeSource = MGLShapeSource(identifier: "marker-source", shape: startPoint, options: nil)
        let shapeLayer = MGLSymbolStyleLayer(identifier: "marker-style", source: shapeSource)
        if let image = UIImage(named: "finishPoint") {
        style.setImage(image, forName: "firstID")
        }
        shapeLayer.iconImageName = NSExpression(forConstantValue: "firstID")
        style.addSource(shapeSource)
        style.addLayer(shapeLayer)
        
        deletedCell = { val in
            if val {
                let endPoint = MGLPointAnnotation()
                let endSource = MGLShapeSource(identifier: "end-source", shape: endPoint, options: nil)
                let endLayer = MGLSymbolStyleLayer(identifier: "end-style", source: endSource)
                if let image = UIImage(named: "point") {
                style.setImage(image, forName: "endID")
                }
                shapeLayer.iconImageName = NSExpression(forConstantValue: "endID")
                
                endPoint.coordinate = CLLocationCoordinate2D(latitude: AddressInformation.d_lat, longitude: AddressInformation.d_lon)
                style.addSource(endSource)
                style.addLayer(endLayer)
            }
        }
        
        
        let carPoint = MGLPointAnnotation()
        let carSource = MGLShapeSource(identifier: "car-source", shape: carPoint, options: nil)
        let carLayer = MGLSymbolStyleLayer(identifier: "car-style", source: carSource)
        if let image = UIImage(named: "yassyCars") {
        style.setImage(image, forName: "carID")
        }
        carLayer.iconImageName = NSExpression(forConstantValue: "carID")
        isDrawCar = { [self] val in
            if val {
                self.carIsMoving = { val in
                    if val {
                    UIView.animate(withDuration: 1.5) {
                        carPoint.coordinate = CLLocationCoordinate2D(latitude: self.provider_lat, longitude: self.provider_lon)
                        carSource.shape = carPoint
                        let bounds = MGLCoordinateBounds(sw: startPoint.coordinate, ne: carPoint.coordinate)
                        mapView.setVisibleCoordinateBounds(bounds, edgePadding: .init(top: 60, left: 60, bottom: sizeScreen / 1.8, right: 60), animated: true, completionHandler: nil)
                    }
                    print("CARPROVIDER\(self.provider_lon)")
                    print("CarIsMovingCarIsMoving")
                    }
                }
                style.addSource(carSource)
                style.addLayer(carLayer)
            }
        }
        
        style.transition.duration = 0.8
    }
    
    deinit {
        print("DeINIT TRUE")
    }
    
    // MARK: DROW ROUTE
    
    func drawPolyLine(){
        let userLocation = CLLocationCoordinate2D(latitude: AddressInformation.s_lat, longitude: AddressInformation.s_lon)
        var secondLocation = CLLocationCoordinate2D(latitude: provider_lat, longitude: provider_lon)
        if checkIf {
            isDrowLine = { [self] val in
                if val {
                    self.calculateRouteFromCustomerToShop(from: userLocation, to: secondLocation)
                }
            }
        }
        
        deletedCell = { [self] val in
            checkIf = false
            if val {
                isDrowLine?(false)
                secondLocation = CLLocationCoordinate2D(latitude: AddressInformation.d_lat, longitude: AddressInformation.d_lon)
                self.calculateRouteFromCustomerToShop(from: userLocation, to: secondLocation)
            }
        }
    }
    
    func getDistance(){
        guard let distance = route?.distance else { return }
        print("Distance is", distance)
       // distanceLabel.text = "Distance:".localized() + " \(distance) " + "m to shop"
    }
    
    func calculateRouteFromCustomerToShop(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        let origin = Waypoint(coordinate: origin, coordinateAccuracy: -1, name: "Customer")
        let destination = Waypoint(coordinate: destination, coordinateAccuracy: -1, name: "Shop")
        
        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination], profileIdentifier: .automobileAvoidingTraffic)
        
        Directions.shared.calculate(routeOptions) { [weak self] (session, result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                guard let route = response.routes?.first, let strongSelf = self else {
                    return
                }
                UIView.animate(withDuration: 1.5) {
                    strongSelf.route = route
                    strongSelf.routeOptions = routeOptions
                    strongSelf.drawRouteFromCustomerToShop(route: route)
                    strongSelf.view.layoutIfNeeded()
                }
            }
            self!.getDistance()
        }
    }

    
    func drawRouteFromCustomerToShop(route: Route){
        guard let routeShape = route.shape, routeShape.coordinates.count > 0 else { return }
        var routeCoordinates = routeShape.coordinates
        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: UInt(routeCoordinates.count))
        if let source = mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource {
            source.shape = polyline
        } else {
            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
            let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
            //lineStyle.lineDashPattern = NSExpression(forConstantValue: [2, 1.5])
            lineStyle.lineColor = NSExpression(forConstantValue: UIColor.yassyOrange)
            lineStyle.lineWidth = NSExpression(forConstantValue: 4)
            if let style = mapView.style, let last = style.layers.last {
                mapView.style?.insertLayer(lineStyle, below: last)
            }
            else {
                mapView.style?.addLayer(lineStyle)
            }
            mapView.style?.addSource(source)
        }
    }
    
    
    func mapViewDidFinishRenderingMap(_ mapView: MGLMapView, fullyRendered: Bool) {
        mapView.updateUserLocationAnnotationViewAnimated(withDuration: 2)
        drawRoute = { val in
            if val {
                UIView.animate(withDuration: 1.5) {
                    self.drawPolyLine()
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
