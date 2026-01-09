//
//  RandomStringExtension.swift
//  SwiftRadioUITests
//
//  Created by Алексей Ряжев on 1/9/26.
//  Copyright © 2026 matthewfecher.com. All rights reserved.
//

import Foundation


extension String {
    
    static func random(length: Int) -> String {
        
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map { _ in letters.randomElement()! })
    }
}
