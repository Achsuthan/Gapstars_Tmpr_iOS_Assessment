//
//  MapFilterViewController.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/10/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapFilterViewController: UIViewController {
    
    lazy var locationManager: CLLocationManager = {
        var manager = CLLocationManager()
        manager.distanceFilter = 10
        manager.desiredAccuracy = kCLLocationAccuracyBest
        return manager
    }()
    
    let mapView: MKMapView = {
        let view = MKMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //Jobs Collection View
    var jobsCollectionView: UICollectionView = {
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize =  UIScreen.main.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        view.collectionViewLayout = layout
        view.backgroundColor = .clear
        return view
    }()
    
    //Back button
    let btBackButton: UIButton = {
        let button  = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        return button
    }()
    
    var jobsViewModel = JobsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    private func setUp(){
        
        //Add map view
        self.view.backgroundColor = .white
        self.view.addSubview(self.mapView)
        self.mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        //Add collection view
        self.view.addSubview(self.jobsCollectionView)
        self.jobsCollectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        self.jobsCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5).isActive = true
        self.jobsCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.jobsCollectionView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        self.jobsCollectionView.delegate = self
        self.jobsCollectionView.dataSource = self
        self.jobsCollectionView.register(CollectionJobsCell.self, forCellWithReuseIdentifier: "CollectionJobsCell")
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        //Add back button
        self.btBackButton.addTarget(self, action: #selector(self.btBack(_:)), for: .touchUpInside)
        self.btBackButton.setBackgroundImage(#imageLiteral(resourceName: "back"), for: .normal)
        self.view.addSubview(self.btBackButton)
        self.btBackButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        self.btBackButton.widthAnchor.constraint(equalToConstant: 34).isActive = true
        self.btBackButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.btBackButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        
        self.btBackButton.layer.cornerRadius = 17
        self.btBackButton.clipsToBounds = true
        
        for location in jobsViewModel.getAllLocation() {
            let annotation = MKPointAnnotation()
            annotation.title = location.title
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            mapView.addAnnotation(annotation)
        }
        
        
    }
    
    @IBAction func btBack(_: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    func updateLocationOnMap(to location: CLLocation, with title: String?) {
        
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.addAnnotation(point)
        
        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
        self.mapView.setRegion(viewRegion, animated: true)
    }
    
    
}

extension MapFilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 220, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let single  = self.jobsViewModel.getSingleJobjs(indexPath.row)
        let location = CLLocation(latitude: Double(single.location.lat) ?? 0.0, longitude: Double(single.location.lng) ?? 0.0)
        let region = MKCoordinateRegion( center: location.coordinate, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.jobsViewModel.getJobsArrayCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let view  = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionJobsCell", for: indexPath) as! CollectionJobsCell
        let single = self.jobsViewModel.getSingleJobjs(indexPath.row)
        view.lblTitle.text = single.title
        if (single.photo != nil) {
            view.imgJobs.sd_setImage(with: URL(string: single.photo ?? ""), placeholderImage: #imageLiteral(resourceName: "loading"))
        }
        else {
            view.imgJobs.image = #imageLiteral(resourceName: "loading")
        }
        return view
    }
    
    
}

extension MapFilterViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
}

extension CLLocation {
    
    func lookUpPlaceMark(_ handler: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        
        // Look up the location and pass it to the completion handler
        geocoder.reverseGeocodeLocation(self) { (placemarks, error) in
            if error == nil {
                let firstLocation = placemarks?[0]
                handler(firstLocation)
            }
            else {
                // An error occurred during geocoding.
                handler(nil)
            }
        }
    }
}


