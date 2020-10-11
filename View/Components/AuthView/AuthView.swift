//
//  AuthView.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/10/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit

class AuthView: UIView {
    //Sign Up
    let btSignUp: ButtonView = {
        let button = ButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.btButton.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        return button
    }()
    //Sign In
    let btSinIn: ButtonView = {
        let button = ButtonView()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        self.backgroundColor = .white
        
        //Add sign up button
        self.addSubview(self.btSignUp)
        self.btSignUp.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.btSignUp.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.btSignUp.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.btSignUp.title = "Sign Up"
        self.btSignUp.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
        
        //Add Sign In button
        self.addSubview(self.btSinIn)
        self.btSinIn.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        self.btSinIn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        self.btSinIn.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.btSinIn.widthAnchor.constraint(equalTo: self.btSignUp.widthAnchor, multiplier: 1).isActive = true
        self.btSinIn.title = "Log In"
        self.btSinIn.isBorder = true
    }
}
