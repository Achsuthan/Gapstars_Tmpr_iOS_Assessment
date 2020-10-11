//
//  ButtonView.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/10/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit

class ButtonView: UIView {
    //Button
    let btButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    //Set the title
    var title: String = "" {
        didSet{
            self.btButton.setTitle(self.title, for: .normal)
        }
    }
    //Set the border
    var isBorder: Bool = false {
        didSet{
            btButton.layer.borderWidth = 1
            btButton.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        //Add button
        self.addSubview(self.btButton)
        self.btButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.btButton.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.btButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.btButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
