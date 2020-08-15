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
    let path = Bundle.allBundles.compactMap { $0.path(forResource: "state", ofType: "json") }.first!
    self.app.launchArguments = [
      "-\(Arguments.initialScreen.rawValue)", "home_screen",
      "-\(Arguments.state.rawValue)", path,
      "-\(Arguments.reset)", "true"
    ]
  }
  
  override func tearDownWithError() throws {
    self.app.terminate()
    try super.tearDownWithError()
  }
  
  func testStartingFromHomeScreen() {
    self.app.launch()
    let homeView = self.app.otherElements[HomeView.AccessibilityIdentifiers.homeView.rawValue]
    XCTAssertTrue(homeView.exists)
  
    XCTAssertEqual(self.app.staticTexts[HomeView.AccessibilityIdentifiers.name.rawValue].label, "Riccardo")
    XCTAssertEqual(self.app.staticTexts[HomeView.AccessibilityIdentifiers.surname.rawValue].label, "Cipolleschi")
    XCTAssertEqual(self.app.staticTexts[HomeView.AccessibilityIdentifiers.age.rawValue].label, "32")
    XCTAssertEqual(self.app.staticTexts[HomeView.AccessibilityIdentifiers.coins.rawValue].label, "0")
    XCTAssertTrue(self.app.buttons[HomeView.AccessibilityIdentifiers.purchase.rawValue].exists)
  }
  
  func testPurchasingCoins_success() {
    self.app.launchArguments.append(contentsOf: ["-\(Arguments.mockPurchase.rawValue)", "true"])
    self.app.launch()
    let homeView = self.app.otherElements[HomeView.AccessibilityIdentifiers.homeView.rawValue]
    XCTAssertTrue(homeView.exists)
  
    self.app.buttons[HomeView.AccessibilityIdentifiers.purchase.rawValue].tap()
    
    XCTAssertEqual(self.app.staticTexts[HomeView.AccessibilityIdentifiers.coins.rawValue].label, "1000")
  }
  
  func testPurchasingCoins_failure() {
    self.app.launchArguments.append(contentsOf: ["-\(Arguments.mockPurchase.rawValue)", "false"])
    self.app.launch()
    let homeView = self.app.otherElements[HomeView.AccessibilityIdentifiers.homeView.rawValue]
    XCTAssertTrue(homeView.exists)
  
    self.app.buttons[HomeView.AccessibilityIdentifiers.purchase.rawValue].tap()
    
    XCTAssertEqual(self.app.staticTexts[HomeView.AccessibilityIdentifiers.coins.rawValue].label, "0")
  }
}
