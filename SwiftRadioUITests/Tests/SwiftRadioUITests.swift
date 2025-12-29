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


final class SwiftRadioUITests: XCTestCase {
    
    let app = XCUIApplication()
    var server: HttpServer!
    var mockStationsData: [[String: Any]] = []
    var responseStatus: ResponseStatuses = .success
    lazy var stationsScreen = StationsScreen(app: app)
    
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        
        server = HttpServer()
        
        mockStationsData = [[
            
            "name": "Absolute Country Hits",
            "streamURL": "http://strm112.1.fm/acountry_mobile_mp3",
            "imageURL": "station-absolutecountry.png",
            "desc": "The Music Starts Here",
            "longDesc": "All your favorite country hits and artists, from Johnny Cash to Taylor Swift, on 1.FM's Absolute Country, playing non-stop crooners and banjos, dance-tunes and fiddles, ballads and harmonicas. Absolute Country focuses on 5th, 6th and 7th generation Country (from the 90s on) but often delves into classic, older tunes as well."
        ]]
        
        //        server["/test"] = { request in
        //            return .ok(.text("Hello from mock server!"))
        //        }
        //
        //        server["/status"] = { request in
        //            print("Status endpoint called")
        //            return .ok(.json(["status": "ok", "message": "Server is running"]))
        //        }
        //
        //        server["/echo"] = { request in
        //
        //            if let message = request.queryParams.first(where: {$0.0 == "message"})?.1 {
        //
        //                return .ok(.json(["echo": message]))
        //            } else {
        //
        //                return .ok(.json(["error": "No message provided"]))
        //            }
        //        }
        //
        //        server["/data"] = { request in
        //
        //            switch request.method {
        //
        //            case "GET":
        //                return .ok(.json(["method": "GET", "description": "Reading data"]))
        //            case "POST":
        //                return .ok(.json(["method": "POST", "description": "Creating data"]))
        //            default:
        //                return .ok(.json(["error": "method not supported"]))
        //            }
        //
        //        }
        
        server["/stations"] = { [weak self] request in
            
            print("🔥 MOCK SERVER: /stations endpoint called!")
            
            var successResponce: HttpResponse = .ok(.json(["station": self?.mockStationsData] ?? []))
            
            switch self?.responseStatus ?? .success {
            
            case .success:
                return successResponce
            case .notFound:
                return .notFound
            case .serverError:
                return .internalServerError
            case .throttling:
                sleep(1)
                return successResponce
            }
        }
        
        try server.start(8080, forceIPv4: true)
        print("✅ Mock server started on http://localhost:8080")
        
    }
    
    override func tearDownWithError() throws {
        
        server.stop()
        print("🛑 Mock server stopped")
    }
    
    
    func testAppLaunches() {
        app.launch()
        
        
        XCTAssertTrue(stationsScreen.isDisplayed())
    }
    
    //    func testMockServerRespondsTest() throws {
    //
    //        let expectation = XCTestExpectation(description: "server responds")
    //
    //        let url = URL(string: "http://localhost:8080/test")!
    //
    //        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
    //
    //            XCTAssertNil(error)
    //
    //            XCTAssertNotNil(data)
    //
    //            if let data = data,
    //               let text = String(data: data, encoding: .utf8) {
    //                        print("📩 Received from server: \(text)")
    //                        XCTAssertEqual(text, "Hello from mock server!")
    //                    }
    //
    //                    expectation.fulfill()
    //                }
    //
    //                task.resume()
    //
    //                // Ждём максимум 5 секунд
    //                wait(for: [expectation], timeout: 5.0)
    //        }
    //
    //    func testMockServerRespondsStatus() throws {
    //
    //        let expectation = XCTestExpectation(description: "server responds")
    //
    //        let url = URL(string: "http://localhost:8080/status")!
    //        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
    //
    //            XCTAssertNil(error)
    //            XCTAssertNotNil(data)
    //
    //            if let data = data,
    //            let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
    //                print("📩 Received from server: \(json)")
    //
    //                XCTAssertEqual(json["status"] as? String, "ok")
    ////                if let statusValue = json["status"] as? String {
    ////                    XCTAssertEqual(statusValue, "ok")
    ////                }
    //            }
    //
    //            expectation.fulfill()
    //        }
    //
    //        task.resume()
    //
    //        wait(for: [expectation], timeout: 5.0)
    //    }
    //
    //    func testMockServerRespondsEcho() throws {
    //
    //        let expectation = XCTestExpectation(description: "server responds")
    //
    //        let url = URL(string: "http://localhost:8080/echo?message=HelloWorld")!
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //
    //                XCTAssertNil(error)
    //                XCTAssertNotNil(data)
    //
    //            if let data = data,
    //               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
    //
    //                print("📩 Received from server: \(json)")
    //
    //                XCTAssertEqual(json["echo"] as? String, "HelloWorld")
    //            }
    //
    //            expectation.fulfill()
    //        }
    //
    //        task.resume()
    //
    //        wait(for: [expectation], timeout: 5.0)
    //    }
    //
    //    func testMockServerRespondsEchoSecond() throws {
    //
    //        let expectation = XCTestExpectation(description: "server responds")
    //
    //        let url = URL(string: "http://localhost:8080/echo")!
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //
    //                XCTAssertNil(error)
    //                XCTAssertNotNil(data)
    //
    //            if let data = data,
    //               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
    //
    //                print("📩 Received from server: \(json)")
    //
    //                XCTAssertEqual(json["error"] as? String, "No message provided")
    //            }
    //
    //            expectation.fulfill()
    //        }
    //
    //        task.resume()
    //
    //        wait(for: [expectation], timeout: 5.0)
    //    }
    //
    //    func testMockServerGetMethod() throws {
    //
    //        let expectation = XCTestExpectation(description: "server responds")
    //
    //        let url = URL(string: "http://localhost:8080/data")!
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //
    //            XCTAssertNil(error)
    //            XCTAssertNotNil(data)
    //
    //            if let data = data,
    //               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
    //
    //                print("📩 Received from server: \(json)")
    //
    //                XCTAssertEqual(json["method"] as? String, "GET")
    //                XCTAssertEqual(json["description"] as? String, "Reading data")
    //            }
    //
    //            expectation.fulfill()
    //        }
    //
    //        task.resume()
    //
    //        wait(for: [expectation], timeout: 5.0)
    //    }
    //
    //    func testMockServerPostMethod() throws {
    //
    //        let expectation = XCTestExpectation(description: "server responds")
    //
    //        let url = URL(string: "http://localhost:8080/data")!
    //        var request = URLRequest(url: url)
    //
    //        request.httpMethod = "POST"
    //
    //        let task = URLSession.shared.dataTask(with: request) { data, response, error in
    //
    //            XCTAssertNil(error)
    //            XCTAssertNotNil(data)
    //
    //            if let data = data,
    //               let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
    //
    //                print("📩 Received from server: \(json)")
    //
    //                XCTAssertEqual(json["method"] as? String, "POST")
    //                XCTAssertEqual(json["description"] as? String, "Creating data")
    //            }
    //
    //            expectation.fulfill()
    //
    //        }
    //
    //        task.resume()
    //
    //        wait(for: [expectation], timeout: 5.0)
    //    }
    
    func testAppLoadStations() throws {
        
        app.launchEnvironment[TestEnv.url] = EndpointURL.stations
        app.launchEnvironment[TestEnv.mockServerToggle] = "true"
        
        app.launch()
        
        sleep(30)
        
        XCTAssertTrue(app.exists)
    }
    
    func testAppLoadsEmptyStations() throws {
        
        mockStationsData = []
        
        app.launchEnvironment["MOCK_STATIONS_URL"] = "http://localhost:8080/stations"
        app.launchEnvironment["USE_MOCK_SERVER"] = "true"
        
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
        
        
        app.launchEnvironment[TestEnv.url] = EndpointURL.stations
        app.launchEnvironment[TestEnv.mockServerToggle] = "true"
        
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
        
        app.launchEnvironment[TestEnv.url] = EndpointURL.stations
        app.launchEnvironment[TestEnv.mockServerToggle] = "true"
        
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
        
        app.launchEnvironment[TestEnv.url] = EndpointURL.stations
        app.launchEnvironment[TestEnv.mockServerToggle] = "true"
        
        responseStatus = .notFound
        
        app.launch()
        print(app.debugDescription)
        XCTAssertTrue(stationsScreen.hasStation(named: "The operation couldn’t be completed. (SwiftRadio.DataError error 4.)"))
    }
    
    func testResponseServerError() {
        
        app.launchEnvironment[TestEnv.url] = EndpointURL.stations
        app.launchEnvironment[TestEnv.mockServerToggle] = "true"
        
        responseStatus = .throttling
        
        app.launch()
        XCTAssertTrue(stationsScreen.hasStation(named: "Test staiton 1"))
    }
    
}


