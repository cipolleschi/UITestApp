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
  var user: Models.User?
  init(user: Models.User?) {
    self.user = user
  }
  
  var name: String {
    return self.user?.name ?? "-"
  }
  
  var surname: String {
    return self.user?.surname ?? "-"
  }
  
  var age: String {
    guard let a = self.user?.age else {
      return "-"
    }
    return "\(a)"
  }
}

class HomeView: UIView {
  
  var viewModel: HomeVM? {
    didSet {
      self.update(self.viewModel)
    }
  }
  
  private var nameLabelTitle = UILabel()
  private var nameLabelValue = UILabel()
  private var surnameLabelTitle = UILabel()
  private var surnameLabelValue = UILabel()
  private var ageLabelTitle = UILabel()
  private var ageLabelValue = UILabel()
  
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
    
    self.addSubview(nameLabelTitle)
    self.addSubview(nameLabelValue)
    self.addSubview(surnameLabelTitle)
    self.addSubview(surnameLabelValue)
    self.addSubview(ageLabelTitle)
    self.addSubview(ageLabelValue)
    
    #if UITESTING
    self.setAcceccibilityIdentifiers()
    #endif
  }
  
  func style() {
    self.backgroundColor = .white
    self.style(label: self.nameLabelTitle, isTitle: true, content: "Name:")
    self.style(label: self.surnameLabelTitle, isTitle: true, content: "Surame:")
    self.style(label: self.ageLabelTitle, isTitle: true, content: "Age:")
    
  }
  
  func update(_ viewModel: HomeVM?) {
    
    self.style(label: self.nameLabelValue, isTitle: false, content: self.viewModel?.name ?? "-" )
    self.style(label: self.surnameLabelValue, isTitle: false, content: self.viewModel?.surname ?? "-")
    self.style(label: self.ageLabelValue, isTitle: false, content: self.viewModel?.age ?? "-")
    
    self.setNeedsLayout()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.layout(label: self.nameLabelTitle, topAnchor: self.safeAreaInsets.top)
    self.layout(label: self.nameLabelValue, topAnchor: self.nameLabelTitle.frame.maxY)
    self.layout(label: self.surnameLabelTitle, topAnchor: self.nameLabelValue.frame.maxY)
    self.layout(label: self.surnameLabelValue, topAnchor: self.surnameLabelTitle.frame.maxY)
    self.layout(label: self.ageLabelTitle, topAnchor: self.surnameLabelValue.frame.maxY)
    self.layout(label: self.ageLabelValue, topAnchor: self.ageLabelTitle.frame.maxY)
    
  }
  
  func layout(label: UILabel, topAnchor: CGFloat) {
    label.frame = .zero
    label.sizeToFit()
    label.frame = CGRect(
      x: 10,
      y: topAnchor + 10,
      width: label.frame.width,
      height: label.frame.height
    )
  }
  
  func style(label: UILabel, isTitle: Bool, content: String) {
    let font = UIFont.systemFont(ofSize: 16, weight: isTitle ? .bold : .regular)
    label.text = content
    label.font = font
    label.textColor = .black
  }
}

// MARK: - Accessibility
#if UITESTING
extension HomeView {
  enum AccessibilityIdentifiers: String {
    case homeView = "home_view"
    case name = "home_view.name_value"
    case surname = "home_view.surname_value"
    case age = "home_view.age_value"
  }
  
  func setAcceccibilityIdentifiers() {
    self.accessibilityIdentifier = AccessibilityIdentifiers.homeView.rawValue
    self.nameLabelValue.accessibilityIdentifier = AccessibilityIdentifiers.name.rawValue
    self.surnameLabelValue.accessibilityIdentifier = AccessibilityIdentifiers.surname.rawValue
    self.ageLabelValue.accessibilityIdentifier = AccessibilityIdentifiers.age.rawValue
  }
}
#endif
