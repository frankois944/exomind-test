//
//  exomind_testTests.swift
//  exomind-testTests
//
//  Created by macartevacances on 27/09/2021.
//

import XCTest
@testable import exomind_test

class exomind_testTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    static let weatherLoadedExpectation = XCTestExpectation(description: "Weather downloaded")
    static let showProgressMessageExpectation = XCTestExpectation(description: "progress message show nb time")
    static let progressUpdatedExpectation = XCTestExpectation(description: "progress value 1")
    
    /// a simple test of how to test a presenter
    /// it's on quick and dirty mode, the mockview should be reusable for another test and the static is not the best solution
    /// So, it must be somewhere outside of the testing class
    func testGetWeather() throws {
        
        let presenter = WeatherPresenter(weatherService: WeatherService()) // should be a offline service but we get the concept :)
        
        exomind_testTests.showProgressMessageExpectation.expectedFulfillmentCount = 8
        
        class mockView : WeatherViewContractProtocol {
            func weatherLoaded(items: [WeatherDataObject]) {
                exomind_testTests.weatherLoadedExpectation.fulfill()
            }
            
            func progressUpdated(current: Double) {
                if (current == 1) {
                    exomind_testTests.progressUpdatedExpectation.fulfill()
                }
            }
            
            func showProgressMessage(_ message: String?) {
                exomind_testTests.showProgressMessageExpectation.fulfill()
            }
            
            func showErrorMessage(_ error: Error) {
            }
        }
        
        presenter.attach(view: mockView())
        presenter.loadWeather()
    
        wait(for: [exomind_testTests.weatherLoadedExpectation,
                   exomind_testTests.showProgressMessageExpectation,
                   exomind_testTests.progressUpdatedExpectation], timeout: 65.0)
        
        presenter.detach()
    }

}
