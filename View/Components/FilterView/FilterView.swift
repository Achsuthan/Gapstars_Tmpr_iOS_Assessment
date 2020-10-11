//
//  FilterView.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/10/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    //Filter
    let viewFilter: TitleWithImageButton = {
        let view = TitleWithImageButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //Map
    let viewMap: TitleWithImageButton = {
        let view = TitleWithImageButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewVertical: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        
        //Add filter view
        self.addSubview(self.viewFilter)
        self.viewFilter.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.viewFilter.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.viewFilter.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.viewFilter.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        self.viewFilter.title = "Filters"
        self.viewFilter.type = 1
        
        //Add Map view
        self.addSubview(self.viewMap)
        self.viewMap.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.viewMap.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.viewMap.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.viewMap.widthAnchor.constraint(equalTo: self.viewFilter.widthAnchor, multiplier: 1).isActive  = true
        self.viewMap.title = "Kaart"
        self.viewMap.type = 2
        
        self.addSubview(self.viewVertical)
        self.viewVertical.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.viewVertical.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -5).isActive = true
        self.viewVertical.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        self.viewVertical.widthAnchor.constraint(equalToConstant: 2).isActive = true
    }
}
