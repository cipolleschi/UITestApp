//
//  UITestingUITests.swift
//  UITestingUITests
//
//  Created by Riccardo Cipolleschi on 31/07/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import XCTest
@testable import UITesting

class LegalTests: XCTestCase {
  
  var app: XCUIApplication!
  var tosButton: XCUIElement!
  var privacyButton: XCUIElement!
  var continueButton: XCUIElement!
  var homeScreen: XCUIElement?
  
  override func setUpWithError() throws {
    continueAfterFailure = false
    self.app = XCUIApplication()
    self.app.launch()
    
    self.tosButton = app.buttons["legal_view.tos_button"]
    self.privacyButton = app.buttons["legal_view.privacy_button"]
    self.continueButton = app.buttons["legal_view.continue_button"]
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    app.terminate()
  }
  
  func testButtonAreSelectedAndEnabledCorrectly() throws {
    
    self.checkLegalStates(
      tosButtonSelected: false,
      privacyButtonSelected: false,
      continueButtonEnabled: false
    )
    
    tosButton.tap()
    
    self.checkLegalStates(
      tosButtonSelected: true,
      privacyButtonSelected: false,
      continueButtonEnabled: false
    )
    
    privacyButton.tap()
    
    self.checkLegalStates(
      tosButtonSelected: true,
      privacyButtonSelected: true,
      continueButtonEnabled: true
    )
    
    tosButton.tap()
    
    self.checkLegalStates(
      tosButtonSelected: false,
      privacyButtonSelected: true,
      continueButtonEnabled: false
    )
  }
  
  func checkLegalStates(
    tosButtonSelected: Bool,
    privacyButtonSelected: Bool,
    continueButtonEnabled: Bool,
    line: UInt = #line,
    file: StaticString = #file
  ) {
    XCTAssertEqual(self.tosButton.isSelected, tosButtonSelected)
    XCTAssertEqual(self.privacyButton.isSelected, privacyButtonSelected)
    XCTAssertEqual(self.continueButton.isEnabled, continueButtonEnabled)
  }
  
  func testAppNavigatesWhenContinuePressed() throws {
    privacyButton.tap()
    tosButton.tap()
    continueButton.tap()
    
    let homeView = app.otherElements["home_view"]
    XCTAssertTrue(homeView.exists)
  }
}
