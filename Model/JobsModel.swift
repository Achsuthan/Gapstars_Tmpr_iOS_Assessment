//
//  JobsModel.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/11/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import Foundation

struct JobsModel: Codable {
    var photo: String?
    var shifts: [Shifts]
    var title: String
    var job_category: JobCategory
    var location: Location
}

struct Shifts: Codable {
    var currency: String
    var earnings_per_hour: Double
    var duration: Double
    var start_time: String
    var end_time: String
}

struct JobCategory: Codable {
    var description: String
}

struct Location: Codable {
    var lng: String
    var lat: String
}
