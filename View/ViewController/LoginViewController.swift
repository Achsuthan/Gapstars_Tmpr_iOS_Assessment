//
//  LoginViewController.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/10/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let lblCommon: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Log In function not available"
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
    }
    
    private func setUp(){
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.lblCommon)
        self.lblCommon.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.lblCommon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.lblCommon.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.lblCommon.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
    }

}
