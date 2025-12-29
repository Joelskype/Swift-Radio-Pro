//
//  StationsScreen.swift
//  SwiftRadioUITests
//
//  Created by Алексей Ряжев on 12/12/25.
//  Copyright © 2025 matthewfecher.com. All rights reserved.
//

import XCTest


final class StationsScreen {
    
    private let app: XCUIApplication
    init(app: XCUIApplication) {
        
        self.app = app
    }
    
    
    //Elements

    
    var table: XCUIElement {
        
        return app.tables.firstMatch
    }
    
    var cells: XCUIElementQuery {
        
        return app.tables.cells
    }
    
    //Actions
    
    func stationsCell(at index: Int) -> XCUIElement {
        
        return cells.element(boundBy: index)
    }
    
    func tapOnStation(at index: Int) {
        cells.element(boundBy: index).tap()
    }
    
    //Assertions
    func isDisplayed() -> Bool {
        
        return table.exists
    }
    
    func hasStation(named name: String) -> Bool {
        
        return app.staticTexts[name].exists
    }
    
    var stationsCount: Int {
        
        return table.cells.count
    }
}
