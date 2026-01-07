//
//  DataGenerator.swift
//  SwiftRadioUITests
//
//  Created by Алексей Ряжев MAGDV on 02.01.2026.
//  Copyright © 2026 matthewfecher.com. All rights reserved.
//

import Foundation


class StationsDataBuilder {
    
    var count: Int
    var excludedFields: [StationPrams]
    var invlaidURL: Bool
    var customValues: [String: Any]
    
    init(count: Int, excludedFields: [StationPrams], invalidURL: Bool, customValues: [String: Any]) {
        self.count = count
        self.excludedFields = excludedFields
        self.invlaidURL = invalidURL
        self.customValues = customValues
    }
    
}
