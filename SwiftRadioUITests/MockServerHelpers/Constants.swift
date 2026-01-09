//
//  Constants.swift
//  SwiftRadioUITests
//
//  Created by Алексей Ряжев on 12/4/25.
//  Copyright © 2025 matthewfecher.com. All rights reserved.
//

import Foundation


enum EndpointURL {
    
    static let stations = "http://localhost:8080/stations"
    
}

enum ImageURL: String, CaseIterable {
    
    case first = "station-absolutecountry.png"
    case second = "az-rock-radio"
    case third = "https://fethica.com/assets/swift-radio/station-therockfm@3x.png"
    case fourh = "station-classicrock"
}
//enum Endpoint {
//    
//    static let sucess = .ok(.json(["station": self?.mockStationsData] ?? []))
//}
