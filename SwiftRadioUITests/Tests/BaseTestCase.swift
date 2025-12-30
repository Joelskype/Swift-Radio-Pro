//
//  BaseTestCase.swift
//  SwiftRadioUITests
//
//  Created by Алексей Ряжев on 12/30/25.
//  Copyright © 2025 matthewfecher.com. All rights reserved.
//

import Foundation
import XCTest
import Swifter

 class BaseTestCase: XCTestCase {
    
    let app = XCUIApplication()
    var server: HttpServer!
    var mockStationsData: [[String: Any]] = []
    var responseStatus: ResponseStatuses = .success
    
    
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
     
     func setupMockEnvironment() {
         
         app.launchEnvironment[TestEnv.url] = EndpointURL.stations
         app.launchEnvironment[TestEnv.mockServerToggle] = "true"
     }
}
