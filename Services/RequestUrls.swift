//
//  ViewController.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/11/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import Foundation

private var port: String = "dev"

struct RequestUrls {
    //URLs
    private static var sandboxUrl = "https://temper.works/api/v1/contractor/shifts?dates=" //Client
    private static var liveUrl = ""
    
    public static func checkBaseUrlPort() -> String{
        return port
    }
    
    public static func getBaseUrl() -> String {
        switch port {
        case "dev":
            return sandboxUrl
        case "live":
            return liveUrl
        default:
            return sandboxUrl
        }
    }
    
    static var getDataUrl = ""
    
    static var getData: String {
        get {
            return getBaseUrl() + getDataUrl
        }
        set {
            getDataUrl = newValue
        }
    }
    
}

