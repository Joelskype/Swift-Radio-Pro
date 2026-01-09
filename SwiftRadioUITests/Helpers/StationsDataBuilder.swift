//
//  DataGenerator.swift
//  SwiftRadioUITests
//
//  Created by Алексей Ряжев MAGDV on 02.01.2026.
//  Copyright © 2026 matthewfecher.com. All rights reserved.
//

import Foundation


class StationsDataBuilder {
    
    private var count: Int = 0
    private var excludedFields: [StationPrams] = []
    private var excludedValues: [StationPrams] = []
    private var invalidURL: Bool = false
    private var customValues: [String: Any] = [:]
    private var textLength: Int = 20
    
    
    func withCount(_ count: Int) -> StationsDataBuilder {
        
        self.count = count
        return self
    }
    
    func withoutFields(_ field: StationPrams) -> StationsDataBuilder {
        
        self.excludedFields.append(field)
        return self
    }
    
    func withEmprtyValue(_ value: StationPrams) -> StationsDataBuilder {
        
        self.excludedValues.append(value)
        return self
    }
    
    func withInvalidURL() -> StationsDataBuilder {
        
        self.invalidURL = true
        return self
    }
    
    func with(_ customValues: [String: Any]) -> StationsDataBuilder {
        
        self.customValues = customValues
        return self
    }
    
    func withTextLength(_ length: Int) -> StationsDataBuilder {
        
        self.textLength = length
        return self
    }
    
    func build() -> [[String: Any]] {
        
        var stations: [[String: Any]] = []
        
        for _ in 0 ..< self.count {
            
            
            var station: [String: Any] = [
                "name": String.random(length: textLength),
                "streamURL": invalidURL ? String.random(length: 3) + " " + ".com" : "http://strm112.1.fm/acountry_mobile_mp3",
                "imageURL": ImageURL.allCases.randomElement()!.rawValue,
                "desc": String.random(length: textLength),
                "longDesc": String.random(length: textLength)
            ]
                        
            for field in excludedFields {
                
                station.removeValue(forKey: field.rawValue)
            }
            
            for field in excludedValues {
                
                station.updateValue("", forKey: field.rawValue)
            }
            
            for pair in customValues {
                    
                station.updateValue(pair.value, forKey: pair.key)
                
            }
            
            stations.append(station)
        }
        
        return stations
    }
}
