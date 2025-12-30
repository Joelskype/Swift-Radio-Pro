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
        
        mockStationsData = [
            
            ["name": "Test staiton 1",
            "streamURL": "http://strm112.1.fm/acountry_mobile_mp3",
            "imageURL": "station-absolutecountry.png",
            "desc": "staiton 1",
            "longDesc": "This is test data for first station"
             ],
            ["name": "Test staiton 2",
            "streamURL": "http://cassini.shoutca.st:9300/stream",
            "imageURL": "https://fethica.com/assets/swift-radio/station-therockfm@3x.png",
            "desc": "staiton 2",
            "longDesc": "This is test data for second station"
             ],
            ["name": "Test staiton 3",
            "streamURL": "http://rfcmedia.streamguys1.com/classicrock.mp3",
            "imageURL": "station-classicrock",
            "desc": "staiton 3",
            "longDesc": "This is test data for third station"
             ]
        ]
        
        app.launch()
        
        XCTAssertTrue(stationsScreen.isDisplayed())
        XCTAssertEqual(stationsScreen.stationsCount, 2)
        XCTAssertTrue(stationsScreen.hasStation(named: "Test staiton 1"))
        
    }
    
    func testEnterOnNowPlayingScreen() throws {
        
        setupMockEnvironment()
        
        mockStationsData = [
            
            ["name": "Test staiton 1",
            "streamURL": "http://strm112.1.fm/acountry_mobile_mp3",
            "imageURL": "station-absolutecountry.png",
            "desc": "staiton 1",
            "longDesc": "This is test data for first station"
             ]
        ]
        
        app.launch()
        
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


