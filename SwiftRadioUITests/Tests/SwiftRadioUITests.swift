//
//  SwiftRadioUITests.swift
//  SwiftRadioUITests
//
//  Created by Jonah Stiennon on 12/3/15.
//  Copyright © 2015 matthewfecher.com. All rights reserved.
//

import XCTest
import Swifter
import Foundation


final class SwiftRadioUITests: BaseTestCase {
    
    lazy var stationsScreen = StationsScreen(app: app)
    
    func testAppLaunches() {
        
        app.launch()
        XCTAssertTrue(stationsScreen.isDisplayed())
    }
    
    func testAppLoadStations() throws {
        
        setupMockEnvironment()
        
        app.launch()
        
        sleep(30)
        
        XCTAssertTrue(app.exists)
    }
    
    func testAppLoadsEmptyStations() throws {
        
        mockStationsData = []
        
        setupMockEnvironment()
        
        app.launch()
        
        XCTAssertTrue(stationsScreen.isDisplayed())
        XCTAssertEqual(stationsScreen.stationsCount, 1)
        XCTAssertTrue(stationsScreen.hasStation(named: "Loading Stations..."))
        
    }
    
    
    func testCheckUi() {
        
        app.launch()
        sleep(4)
        print("===UI DEBUG===")
        print(app.debugDescription)
    }
    
    
    func testAppLoadsMultiplyStations() throws {
        
        
        setupMockEnvironment()
        
        mockStationsData = StationsDataBuilder().withCount(5).build()
        
        app.launch()
        
        XCTAssertTrue(stationsScreen.isDisplayed())
        XCTAssertEqual(stationsScreen.stationsCount, 1)
        XCTAssertTrue(stationsScreen.hasStation(named: "Test staiton 1"))
    }
    
    func testEnterOnNowPlayingScreen() throws {
        
        setupMockEnvironment()
        
        mockStationsData =
        StationsDataBuilder()
            .withCount(3)
            .build()
        
        app.launch()
        print(mockStationsData)
        sleep(123)
        
        stationsScreen.tapOnStation(at: 0)
        XCTAssertEqual(app.sliders.firstMatch.label, "Volume")
    }
    
    func testResponceNotFound() {
        
        setupMockEnvironment()
        
        responseStatus = .notFound
        
        app.launch()
        print(app.debugDescription)
        XCTAssertTrue(stationsScreen.hasStation(named: "The operation couldn’t be completed. (SwiftRadio.DataError error 4.)"))
    }
    
    func testResponseServerError() {
        
        setupMockEnvironment()
        
        responseStatus = .throttling
        
        app.launch()
        XCTAssertTrue(stationsScreen.hasStation(named: "Test staiton 1"))
    }
    
}


