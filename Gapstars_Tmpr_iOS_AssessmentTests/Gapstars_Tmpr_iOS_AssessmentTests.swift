//
//  Gapstars_Tmpr_iOS_AssessmentTests.swift
//  Gapstars_Tmpr_iOS_AssessmentTests
//
//  Created by Achsuthan Mahendran on 10/10/20.
//  Copyright © 2020 Achsuthan Mahendran. All rights reserved.
//

import XCTest
@testable import Gapstars_Tmpr_iOS_Assessment

class Gapstars_Tmpr_iOS_AssessmentTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let tmp = JobsViewModel()
        self.checkIsAPICalled(tmp, false)
        
        self.checkBaseUrl()
        
        self.checkBaseUrlPort()
        
        self.successAPICallTest(tmp)
        
        self.checkReset(tmp)
        
        self.checkTodayDateString(tmp)
        
        self.addJobsArray(tmp)
        
        self.checkSingleJobs(tmp)
        
        self.checkLocationArray(tmp)
    }
    //check single jobs
    func checkSingleJobs(_ tmp: JobsViewModel){
        XCTAssertEqual(tmp.getSingleJobjs(0), JobsModel(photo: "test", shifts: [Shifts(currency: "$", earnings_per_hour: 1, duration: 1, start_time: "10:00", end_time: "11:00")], title: "testing", job_category: JobCategory(description: "testing"), location: Location(lng: "1.0", lat: "1.0")), "check Single Jobs")
    }
    
    func checkLocationArray(_ tmp: JobsViewModel){
        XCTAssertEqual(tmp.getAllLocation(),[LocationMap(title: "testing", latitude: 1.0, longitude: 1.0)], " check Location Array")
    }
    
    //Add values to jobs
    func addJobsArray(_ tmp: JobsViewModel){
        tmp.addJobsArray([JobsModel(photo: "test", shifts: [Shifts(currency: "$", earnings_per_hour: 1, duration: 1, start_time: "10:00", end_time: "11:00")], title: "testing", job_category: JobCategory(description: "testing"), location: Location(lng: "1.0", lat: "1.0"))])
        
    }
    
    //Check the current date
    func checkTodayDateString(_ tmp: JobsViewModel){
        let todayDateString = tmp.getTodayDateString()
        let todayCalanderDate = Calendar.current.dateComponents([.day, .year, .month, .weekday], from: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let nameOfMonth = dateFormatter.string(from: Date())
        
        let check = "\((todayCalanderDate.weekday ?? 0).getWeekDay()) \(todayCalanderDate.day ?? 0) \(nameOfMonth)"
        
        
        XCTAssertEqual(tmp.getTodayDateString(),check , " check Today Date String")
    }
    
    //Check reset function
    func checkReset(_ tmp: JobsViewModel) {
        tmp.reset()
        let viewModelCalanderDate = Calendar.current.dateComponents([.day, .year, .month], from: tmp.getLastDate())
        
        let currenttimecalanderDate = Calendar.current.dateComponents([.day, .year, .month], from: Date())
        XCTAssertEqual(viewModelCalanderDate.day ?? 0, currenttimecalanderDate.day ?? 0, "checkReset Date")
    }
    
    //Initial it will be false
    func checkIsAPICalled(_ tmp: JobsViewModel, _ status: Bool){
        XCTAssertEqual(tmp.getIsAPICalled(), status, "checkInternetStatus")
    }
    
    //RequestURL check
    func checkBaseUrl(){
        XCTAssertEqual(RequestUrls.getBaseUrl(), "https://temper.works/api/v1/contractor/shifts?dates=", "requestUrl check")
    }
    
    func checkBaseUrlPort(){
        XCTAssertEqual(RequestUrls.checkBaseUrlPort(), "dev", "checkBaseUrlPort")
    }
    
    
    //Failure API call test
    func successAPICallTest(_ tmp: JobsViewModel){
        let lastDate = Date()
        let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: lastDate)!
        let dayAfterTomorrowDate = Calendar.current.date(byAdding: .day, value: 2, to: lastDate)!
        
        let todayCalanderDate = Calendar.current.dateComponents([.day, .year, .month], from: lastDate)
        
        let tomorrowCalanderDate = Calendar.current.dateComponents([.day, .year, .month], from: tomorrowDate)
        
        let dayAfterTomorrowCalanderDate = Calendar.current.dateComponents([.day,.year,.month], from: dayAfterTomorrowDate)
        
        
        let todayDateString = "\(todayCalanderDate.year ?? 0)-\(todayCalanderDate.month ?? 0)-\(todayCalanderDate.day ?? 0)"
        
        let tomorrowDateString = "\(tomorrowCalanderDate.year ?? 0)-\(tomorrowCalanderDate.month ?? 0)-\(tomorrowCalanderDate.day ?? 0)"
        
        let dayafterTomorrowDateString = "\(dayAfterTomorrowCalanderDate.year ?? 0)-\(dayAfterTomorrowCalanderDate.month ?? 0)-\(dayAfterTomorrowCalanderDate.day ?? 0)"
        
        RequestUrls.getData = "\(todayDateString),\(tomorrowDateString),\(dayafterTomorrowDateString)"
        
        let exp = expectation(description: "GET \(RequestUrls.getDataUrl)")
        UserHelper.callAPI(urlName: .getData, method: .get, parameters: [:]) { (status, result, error) in
            XCTAssert(status == true, "successAPICallTest")
            exp.fulfill()
        }
        waitForExpectations(timeout: 15){ error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
