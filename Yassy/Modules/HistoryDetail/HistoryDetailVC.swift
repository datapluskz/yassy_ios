//
//  HistoryDetailVC.swift
//  OrangeTaxi
//
//  Created by Didar Bakhitzhanov on 09.05.2021.
//

import UIKit
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections

class HistoryDetailVC: UIViewController {
    
    lazy var url = URL(string: "mapbox://styles/mapbox/streets-v11")
    lazy var mapView = NavigationMapView(frame: .zero, styleURL: url)
    var routeOptions: NavigationRouteOptions?
    var route: Route?
    lazy var tableView = UITableView(frame: .zero)
    
    var viewModel: HistoryDetailViewModel
    
    init(viewModel: HistoryDetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        callingViewModelForUIUpdate()
    }
    
    fileprivate func setupViews(){
        view.backgroundColor = .white
        setupNavigationBar()
        mapView.logoView.isHidden = true
        mapView.delegate = self
        mapView.showsUserLocation = true
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 20
        view.addSubview(mapView)
        view.addSubview(tableView)
        mapView.setAnchor(top: view.topAnchor, left: view.leftAnchor,
                          bottom: nil, right: view.rightAnchor,
                          paddingTop: 0, paddingLeft: 0,
                          paddingBottom: 0, paddingRight: 0, height: 250)
        tableView.setAnchor(top: mapView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: -20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        setupTableView()
    }
    
    private func setupNavigationBar(){
        title = "История заказов"
        navigationItem.leftBarButtonItem = navigationController?.addBackButton()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    private func setupTableView(){
        tableView.register(HistoryDetailCell.self, forCellReuseIdentifier: HistoryDetailCell.description())
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func callingViewModelForUIUpdate(){
        viewModel.bindHistoryDataToController = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.drawPolyLine()
            }
        }
    }
    
    func drawPolyLine(){
        guard let firstLat = viewModel.historyData?.historyModel.s_latitude else { return }
        guard let firstLng = viewModel.historyData?.historyModel.s_longitude else { return }
        guard let secondLat = viewModel.historyData?.historyModel.d_latitude else { return }
        guard let secondLng = viewModel.historyData?.historyModel.d_longitude else { return }
      
        let firstCoord = CLLocationCoordinate2D(latitude: firstLat, longitude: firstLng)
        let secondCoord = CLLocationCoordinate2D(latitude: secondLat, longitude: secondLng)
        let firstAnn = MGLPointAnnotation()
        firstAnn.coordinate = firstCoord
        let secondAnn = MGLPointAnnotation()
        secondAnn.coordinate = secondCoord
        
        let bounds = MGLCoordinateBounds(sw: firstCoord, ne: secondCoord)
        mapView.setVisibleCoordinateBounds(bounds, animated: true)
//        mapView.setCenter(firstCoord, zoomLevel: 14, animated: false)
        mapView.addAnnotation(firstAnn)
        mapView.addAnnotation(secondAnn)
        calculateRoute(from: firstCoord, to: secondCoord)
    }
    
    func calculateRoute(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
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
                strongSelf.route = route
                strongSelf.routeOptions = routeOptions
                strongSelf.drawRoute(route: route)
            }
        }
    }
    
    func drawRoute(route: Route){
        guard let routeShape = route.shape, routeShape.coordinates.count > 0 else { return }
        var routeCoordinates = routeShape.coordinates
        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: UInt(routeCoordinates.count))
        if let source = mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource {
            source.shape = polyline
        } else {
            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
            let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
            lineStyle.lineColor = NSExpression(forConstantValue: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
            lineStyle.lineWidth = NSExpression(forConstantValue: 3)
            mapView.style?.addSource(source)
            mapView.style?.addLayer(lineStyle)
        }
    }
    
}

extension HistoryDetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryDetailCell.description(), for: indexPath) as! HistoryDetailCell
        if let historyModel = viewModel.historyData {
            cell.historyModel = historyModel
        }
        return cell
    }
    
    
}

extension HistoryDetailVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HistoryDetailVC: MGLMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
//        if let coord = mapView.userLocation?.coordinate {
//            mapView.setCenter(coord, zoomLevel: 12, animated: false)
//        }
    }
}
