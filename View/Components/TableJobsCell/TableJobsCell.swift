//
//  TableJobsCell.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/10/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit

class TableJobsCell: UITableViewCell {
    
    //Background View
    let viewBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    //Jobs Image
    let imgJob: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    //Discription and Distance
    let lblDiscriptionAndDistance: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.text = "Something . 12Km"
        label.textColor = .purple
        return label
    }()
    
    //Job title
    let lblJobTitle: UILabel = {
        let label  = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.text = "ML"
        return label
    }()
    
    //Working Hours
    let lblWorkingHours: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.text = "10:00 - 11:00"
        label.textColor = .black
        return label
    }()
    
    //Price view
    let viewPrice: UIView = {
        let view  = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    //Price label
    let lblPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.text = "$12"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        //Add background view
        self.addSubview(self.viewBackground)
        self.viewBackground.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.viewBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.viewBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.viewBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.viewBackground.heightAnchor.constraint(greaterThanOrEqualToConstant: 220).isActive = true
        
        //Add Job image
        self.viewBackground.addSubview(self.imgJob)
        self.imgJob.topAnchor.constraint(equalTo: self.viewBackground.topAnchor).isActive = true
        self.imgJob.leadingAnchor.constraint(equalTo: self.viewBackground.leadingAnchor).isActive = true
        self.imgJob.trailingAnchor.constraint(equalTo: self.viewBackground.trailingAnchor).isActive = true
        self.imgJob.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        //Add Discription and Distance
        self.viewBackground.addSubview(self.lblDiscriptionAndDistance)
        self.lblDiscriptionAndDistance.topAnchor.constraint(equalTo: self.imgJob.bottomAnchor, constant: 10).isActive = true
        self.lblDiscriptionAndDistance.leadingAnchor.constraint(equalTo: self.viewBackground.leadingAnchor).isActive = true
        self.lblDiscriptionAndDistance.trailingAnchor.constraint(equalTo: self.viewBackground.trailingAnchor, constant: -20).isActive = true
        
        //Add Job title
        self.viewBackground.addSubview(self.lblJobTitle)
        self.lblJobTitle.topAnchor.constraint(equalTo: self.lblDiscriptionAndDistance.bottomAnchor, constant: 5).isActive = true
        self.lblJobTitle.leadingAnchor.constraint(equalTo: self.viewBackground.leadingAnchor).isActive = true
        self.lblJobTitle.trailingAnchor.constraint(equalTo: self.viewBackground.trailingAnchor).isActive = true
        
        //Add working hours
        self.viewBackground.addSubview(self.lblWorkingHours)
        self.lblWorkingHours.topAnchor.constraint(equalTo: self.lblJobTitle.bottomAnchor, constant: 5).isActive = true
        self.lblWorkingHours.leadingAnchor.constraint(equalTo: self.viewBackground.leadingAnchor).isActive = true
        self.lblWorkingHours.trailingAnchor.constraint(equalTo: self.viewBackground.trailingAnchor).isActive = true
        self.lblWorkingHours.bottomAnchor.constraint(equalTo: self.viewBackground.bottomAnchor, constant: -10).isActive = true
        
        //Add Price View
        self.viewBackground.addSubview(self.viewPrice)
        self.viewPrice.trailingAnchor.constraint(equalTo: self.imgJob.trailingAnchor, constant: 8).isActive = true
        self.viewPrice.bottomAnchor.constraint(equalTo: self.imgJob.bottomAnchor, constant: 8).isActive = true
        self.viewPrice.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Add Price
        self.viewPrice.addSubview(self.lblPrice)
        self.lblPrice.leadingAnchor.constraint(equalTo: self.viewPrice.leadingAnchor, constant: 5).isActive = true
        self.lblPrice.trailingAnchor.constraint(equalTo: self.viewPrice.trailingAnchor, constant: -10).isActive = true
        self.lblPrice.centerYAnchor.constraint(equalTo: self.viewPrice.centerYAnchor).isActive = true
    }
}
