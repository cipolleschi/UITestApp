//
//  HomeView.swift
//  UITesting
//
//  Created by Riccardo Cipolleschi on 01/08/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import UIKit

struct HomeVM {
  
}

class HomeView: UIView {
  
  var viewModel: HomeVM? {
    didSet {
      self.update(self.viewModel)
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.setup()
    self.style()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setup()
    self.style()
  }
  
  func setup() {
    #if UITESTING
    self.setAcceccibilityIdentifiers()
    #endif
  }
  
  func style() {
    self.backgroundColor = .blue
  }
  
  func update(_ viewModel: HomeVM?) {
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
}

// MARK: - Accessibility
#if UITESTING
extension HomeView {
  enum AccessibilityIdentifiers: String {
    case homeView = "home_view"
  }
  
  func setAcceccibilityIdentifiers() {
    self.accessibilityIdentifier = AccessibilityIdentifiers.homeView.rawValue
  }
}
#endif
