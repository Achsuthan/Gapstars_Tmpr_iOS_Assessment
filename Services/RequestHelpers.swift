//
//  ViewController.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/11/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import Foundation

import Foundation
import SwiftyJSON
import Alamofire
//import ObjectMapper

class UserHelper: HeaderHelper {
    
    static func callAPI(urlName: urlName, method: HttpMethod, parameters: [String:Any],completion: @escaping ((_ isSuccess: Bool, _ response: JSON?, _ error: AFError?) -> ())) {
        
        let tparameter = parameters
        
        var urlString = ""
        var Httpmethod: HTTPMethod = .get
        
        switch urlName {
        case .getData:
            urlString = RequestUrls.getData
            
            switch method {
            case .get:
                Httpmethod = .get
            case .post:
                Httpmethod = .post
            case .put:
                Httpmethod = .put
            case .delete:
                Httpmethod = .delete
            }
            Alamofire.request(urlString,method: Httpmethod, parameters: tparameter.count > 0 ? tparameter : nil, encoding: JSONEncoding.default, headers: getCommonHeaders()).responseJSON { (dataResponse) in
                if dataResponse.result.isSuccess {
                    let resultJSON = JSON(dataResponse.result.value!)
                    
                    if resultJSON["error"].stringValue  == "Unauthenticated." {
                        return
                    }
                    completion(true, resultJSON, nil)
                } else {
                    return
                }
            }
        }
    }
}
