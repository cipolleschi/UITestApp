//
//  HomeTests.swift
//  UITestingUITests
//
//  Created by Riccardo Cipolleschi on 08/08/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import XCTest
@testable import UITesting

class HomeTests: XCTestCase {
  
  var app: XCUIApplication!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    continueAfterFailure = false
    self.app = XCUIApplication()
    self.app.launchArguments = ["-initialScreen", "home_screen"]
    self.app.launch()
  }
  
  override func tearDownWithError() throws {
    self.app.terminate()
    try super.tearDownWithError()
  }
  
  func testStartingFromHomeScreen() {
    let homeView = self.app.otherElements[HomeView.AccessibilityIdentifiers.homeView.rawValue]
    XCTAssertTrue(homeView.exists)
  }
}
