//
//  CollectionJobsCell.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/10/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit

class CollectionJobsCell: UICollectionViewCell {
    
    //Background View
    let viewBackground: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    
    //Jobs Image
    let imgJobs: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .gray
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    //Job title
    let lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Dummy"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        //Add View background
        self.addSubview(self.viewBackground)
        self.viewBackground.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.viewBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.viewBackground.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.viewBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.viewBackground.heightAnchor.constraint(greaterThanOrEqualToConstant: 180).isActive = true
        
        //Add Image
        self.viewBackground.addSubview(self.imgJobs)
        self.imgJobs.topAnchor.constraint(equalTo: self.viewBackground.topAnchor).isActive = true
        self.imgJobs.leadingAnchor.constraint(equalTo: self.viewBackground.leadingAnchor).isActive = true
        self.imgJobs.trailingAnchor.constraint(equalTo: self.viewBackground.trailingAnchor).isActive = true
        self.imgJobs.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75).isActive = true
        
        //Add jobs title
        self.viewBackground.addSubview(self.lblTitle)
        self.lblTitle.topAnchor.constraint(equalTo: self.imgJobs.bottomAnchor).isActive = true
        self.lblTitle.leadingAnchor.constraint(equalTo: self.viewBackground.leadingAnchor, constant: 10).isActive = true
        self.lblTitle.trailingAnchor.constraint(equalTo: self.viewBackground.trailingAnchor, constant: -5).isActive = true
        self.lblTitle.bottomAnchor.constraint(equalTo: self.viewBackground.bottomAnchor, constant: -5).isActive = true
    }
}
