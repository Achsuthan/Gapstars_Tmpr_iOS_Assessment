//
//  JobsViewModel.swift
//  Gapstars_Tmpr_iOS_Assessment
//
//  Created by Achsuthan Mahendran on 10/11/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import Foundation
import SwiftyJSON


class JobsViewModel {
    
    private var lastDate: Date = Date()
    private var isAPICalled: Bool = false
    private var jobsArray:[JobsModel] = []
    
    //Get api is called or not
    public func getIsAPICalled() -> Bool{
        return self.isAPICalled
    }
    
    //Get the jobs array count
    public func getJobsArrayCount()-> Int {
        return self.jobsArray.count
    }
    
    //Get single job
    public func getSingleJobjs(_ index: Int) -> JobsModel {
        return self.jobsArray[index]
    }
    
    //Get the price
    public func getPrice(_ index: Int)-> Int {
        if self.jobsArray[index].shifts.count > 0 {
            let single = self.jobsArray[index].shifts[0]
            return Int((single.earnings_per_hour * single.duration).rounded(.up))
        }
        else{
            return 0
        }
    }
    
    //Get the last date
    public func getLastDate()-> Date {
        return self.lastDate
    }
    
    
    //Get the today string
    public func getTodayDateString()-> String {
        let todayCalanderDate = Calendar.current.dateComponents([.day, .year, .month, .weekday], from: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: Date())
        
        return "\((todayCalanderDate.weekday ?? 0).getWeekDay()) \(todayCalanderDate.day ?? 0) \(nameOfMonth)"
    }
    
    //pagination handler function
    public func needToCallAPI(_ currentIndex: Int)-> Bool{
        return currentIndex >= self.jobsArray.count - 5 && !isAPICalled
    }
    
    //Reset the pull down refresh
    public func reset(){
        self.lastDate = Date()
    }
    
    //Get all the location array for map
    public func getAllLocation()-> [LocationMap]{
        let location = self.jobsArray.enumerated().map{(index, element) in
            return LocationMap(title: element.title, latitude: Double(element.location.lat) ?? 0.0, longitude: Double(element.location.lng) ?? 0.0)
            
        }
        return location
    }
    
    //Get all the jobs from remote
    public func getJobs(completionHandler: @escaping (_ success:Bool) -> Void){
        
        if !self.isAPICalled {
            self.isAPICalled = true
            
            let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: lastDate)!
            let dayAfterTomorrowDate = Calendar.current.date(byAdding: .day, value: 2, to: lastDate)!
            
            let todayCalanderDate = Calendar.current.dateComponents([.day, .year, .month], from: self.lastDate)
            
            let tomorrowCalanderDate = Calendar.current.dateComponents([.day, .year, .month], from: tomorrowDate)
            
            let dayAfterTomorrowCalanderDate = Calendar.current.dateComponents([.day,.year,.month], from: dayAfterTomorrowDate)
            
            self.lastDate = dayAfterTomorrowDate
            
            let todayDateString = "\(todayCalanderDate.year ?? 0)-\(todayCalanderDate.month ?? 0)-\(todayCalanderDate.day ?? 0)"
            
            let tomorrowDateString = "\(tomorrowCalanderDate.year ?? 0)-\(tomorrowCalanderDate.month ?? 0)-\(tomorrowCalanderDate.day ?? 0)"
            
            let dayafterTomorrowDateString = "\(dayAfterTomorrowCalanderDate.year ?? 0)-\(dayAfterTomorrowCalanderDate.month ?? 0)-\(dayAfterTomorrowCalanderDate.day ?? 0)"
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            RequestUrls.getData = "\(todayDateString),\(tomorrowDateString),\(dayafterTomorrowDateString)"
            UserHelper.callAPI(urlName: .getData, method: .get, parameters: [ : ]) { (status, result, error) in
                if status {
                    let response = result?.dictionaryObject!
                    let data = response?["data"] as? [String: Any]
                    if (data != nil) {
                        self.isAPICalled = false
                        let todayArray = self.getDataArray(result: result!["data"][tomorrowDateString])
                        let yesterDayArray = self.getDataArray(result: result!["data"][todayDateString])
                        let dayBeforeYesterdayArray = self.getDataArray(result: result!["data"][dayafterTomorrowDateString])
                        self.jobsArray.append(contentsOf: todayArray)
                        self.jobsArray.append(contentsOf: yesterDayArray)
                        self.jobsArray.append(contentsOf: dayBeforeYesterdayArray)
                        completionHandler(true)
                    }
                    else {
                        self.isAPICalled = false
                        appDelegate.showToasterMessage("Something went wrong, try restarting the app few minutes")
                        
                    }
                }
                else {
                    self.isAPICalled = false
                    appDelegate.showToasterMessage("Something went wrong, try restarting the app few minutes")
                }
            }
        }    }
    
    private func getDataArray(result: JSON)-> [JobsModel]{
        var jobsArray:[JobsModel] = []
        if let jsonData = try? JSONEncoder().encode(result),
            let jsonString = String(data: jsonData, encoding: .utf8) {
            if let data = jsonString.data(using: .utf8),
                let jobs = try? JSONDecoder().decode([JobsModel].self, from: data) {
                jobsArray = jobs
            }
        }
        return jobsArray
    }
    
    #if DEBUG
    //use this function only for testing purpose
    public func addJobsArray(_ data: [JobsModel]){
        self.jobsArray = data
    }
    #endif
}

extension Int {
    func getWeekDay()-> String {
        switch self {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Friday"
        case 6:
            return "Saturday"
        default:
            return "Sunday"
        }
    }
}
