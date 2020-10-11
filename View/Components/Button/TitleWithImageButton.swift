//
//  TitleWithImageButton.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/10/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import UIKit

class TitleWithImageButton: UIView {
    
    //Image
    let btImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = image.image?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.gray
        return image
    }()
    
    //Title label
    let lblTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    //Button
    let btButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var title: String = "" {
        didSet{
            self.lblTitle.text = self.title
        }
    }
    
    var type: Int = 0 {
        didSet{
            switch self.type {
            case 1:
                self.btImage.image = #imageLiteral(resourceName: "filter_filter")
            case 2:
                self.btImage.image = #imageLiteral(resourceName: "filter_map")
            default:
                self.btImage.image = #imageLiteral(resourceName: "filter_filter")
            }
            
            self.btImage.image = self.btImage.image?.withRenderingMode(.alwaysTemplate)
            self.btImage.tintColor = UIColor.black.withAlphaComponent(0.5)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        //Add image
        self.addSubview(self.btImage)
        self.btImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.btImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        self.btImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.btImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        //Add title
        self.addSubview(self.lblTitle)
        self.lblTitle.leadingAnchor.constraint(equalTo: self.btImage.trailingAnchor, constant: 5).isActive = true
        self.lblTitle.centerYAnchor.constraint(equalTo: self.btImage.centerYAnchor).isActive = true
        self.lblTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        
        self.addSubview(self.btButton)
        self.btButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        self.btButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        self.btButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.btButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
