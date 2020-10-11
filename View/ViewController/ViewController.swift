//
//  ViewController.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/10/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit
import SDWebImage
import CoreLocation

class ViewController: UIViewController {
    
    //Date label
    let lblDate: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        label.text = "10th October 2020"
        return label
    }()
    
    //Table for jobs
    let tblJobs: UITableView = {
        let tabel = UITableView()
        tabel.translatesAutoresizingMaskIntoConstraints = false
        tabel.backgroundColor = .clear
        tabel.separatorStyle = .none
        return tabel
    }()
    
    //Auth View
    let viewAuth: AuthView = {
        let view = AuthView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Common Filter view
    let viewCommonFilter: FilterView = {
        let view = FilterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.gray.withAlphaComponent(0.3).cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 2
        view.backgroundColor = .white
        return view
    }()
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Pagination handler using scroll
        if scrollView == tblJobs {
            for cell in tblJobs.visibleCells {
                let indexPath = tblJobs.indexPath(for: cell)
                if self.jobsViewModel.needToCallAPI(indexPath?.row ?? 0){
                    self.jobsViewModel.getJobs { (status) in
                        if(status){
                            DispatchQueue.main.async {
                                self.tblJobs.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    //Pulldown
    var refreshControl = UIRefreshControl()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        self.setUp()
    }
    var userLocation: CLLocationCoordinate2D!
    let jobsViewModel = JobsViewModel()
    override func viewDidAppear(_ animated: Bool) {
        self.lblDate.text = self.jobsViewModel.getTodayDateString()
        self.jobsViewModel.getJobs { (status) in
            if(status){
                DispatchQueue.main.async {
                    self.tblJobs.reloadData()
                }
            }
        }
    }
    
    private func setUp(){
        self.view.backgroundColor = .white
        
        //Add date label to view
        self.view.addSubview(self.lblDate)
        self.lblDate.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        self.lblDate.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.lblDate.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        
        //Set up Auth View
        self.view.addSubview(self.viewAuth)
        self.viewAuth.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        self.viewAuth.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.viewAuth.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.viewAuth.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.viewAuth.btSignUp.btButton.addTarget(self, action: #selector(self.btSignUp(_:)), for: .touchUpInside)
        self.viewAuth.btSinIn.btButton.addTarget(self, action: #selector(self.btLogin(_:)), for: .touchUpInside)
        
        //Set up the table view
        self.view.addSubview(self.tblJobs)
        self.tblJobs.topAnchor.constraint(equalTo: self.lblDate.bottomAnchor, constant: 20).isActive = true
        self.tblJobs.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        self.tblJobs.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        self.tblJobs.bottomAnchor.constraint(equalTo: self.viewAuth.topAnchor).isActive = true
        self.tblJobs.delegate = self
        self.tblJobs.dataSource = self
        self.tblJobs.register(TableJobsCell.self, forCellReuseIdentifier: "TableJobsCell")
        
        //Setup common filter view
        self.view.addSubview(self.viewCommonFilter)
        self.viewCommonFilter.bottomAnchor.constraint(equalTo: self.viewAuth.topAnchor, constant: -20).isActive = true
        self.viewCommonFilter.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        self.viewCommonFilter.trailingAnchor.constraint(equalTo: self.viewAuth.trailingAnchor, constant: -40).isActive = true
        self.viewCommonFilter.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.viewCommonFilter.layer.cornerRadius = 30
        self.viewCommonFilter.clipsToBounds = true
        self.viewCommonFilter.viewFilter.btButton.addTarget(self, action: #selector(self.btFilter(_:)), for: .touchUpInside)
        self.viewCommonFilter.viewMap.btButton.addTarget(self, action: #selector(self.btMap(_:)), for: .touchUpInside)
        
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblJobs.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @IBAction func refresh(_: Any){
        if !self.jobsViewModel.getIsAPICalled(){
            self.jobsViewModel.reset()
            self.jobsViewModel.getJobs { (status) in
                if status{
                    self.refreshControl.endRefreshing()
                    DispatchQueue.main.async {
                        self.tblJobs.reloadData()
                    }
                }
            }
        }
        else {
            self.refreshControl.endRefreshing()
        }
        
    }
    
    @IBAction func btMap(_: Any){
        let map = MapFilterViewController(nibName: nil, bundle: nil)
        map.jobsViewModel = self.jobsViewModel
        self.navigationController?.pushViewController(map, animated: true)
    }
    
    @IBAction func btFilter(_: Any){
        let alertController = UIAlertController(title: "", message: "Function not available", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btLogin(_: Any){
        self.present(LoginViewController(nibName: nil, bundle: nil), animated: true, completion: nil)
    }
    
    @IBAction func btSignUp(_: Any){
        self.present(SignUpViewController(nibName: nil, bundle: nil), animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate  {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.userLocation = locValue
        print("locValue", locValue)
        DispatchQueue.main.async {
            self.tblJobs.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jobsViewModel.getJobsArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let view = tableView.dequeueReusableCell(withIdentifier: "TableJobsCell", for: indexPath) as! TableJobsCell
        let single = self.jobsViewModel.getSingleJobjs(indexPath.row)
        view.lblPrice.text = "€\(self.jobsViewModel.getPrice(indexPath.row))"
        if (single.photo != nil) {
            view.imgJob.sd_setImage(with: URL(string: single.photo ?? ""), placeholderImage: #imageLiteral(resourceName: "loading"))
        }
        else {
            view.imgJob.image = #imageLiteral(resourceName: "loading")
        }
        view.lblJobTitle.text = single.title
       
        
        if (self.userLocation != nil) {
            let userLocation = CLLocation(latitude: self.userLocation.latitude, longitude: self.userLocation.longitude)
            let jobsLocation = CLLocation(latitude: Double(single.location.lat) ?? 0.0, longitude: Double(single.location.lng) ?? 0.0)

                   let distanceInMeters = userLocation.distance(from: jobsLocation)
            
            view.lblDiscriptionAndDistance.text = single.job_category.description + " . \(Int(distanceInMeters/1000.rounded(.up)))Km"
        }
        else {
            view.lblDiscriptionAndDistance.text = single.job_category.description
        }
        if single.shifts.count > 0 {
            let singleShift = single.shifts[0]
            view.lblWorkingHours.text = singleShift.start_time + " - " + singleShift.end_time
        }
        view.selectionStyle = .none
        return view
    }
}

