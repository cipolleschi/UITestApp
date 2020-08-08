//
//  LegalView.swift
//  UITesting
//
//  Created by Riccardo Cipolleschi on 31/07/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import UIKit

typealias Interaction = () -> ()

struct LegalVM {
  let tosChecked: Bool
  let privacyChecked: Bool
  
  var buttonEnabled: Bool {
    return tosChecked && privacyChecked
  }
}

class LegalView: UIView {
  var viewModel: LegalVM? = nil {
    didSet {
      self.update(oldModel: self.viewModel)
    }
  }
  
  private var titleLabel = UILabel()
  private var descriptionLabel = UILabel()
  private var tosButton = UIButton()
  private var privacyButton = UIButton()
  private var continueButton = UIButton()
  
  var userDidTapTosButton: Interaction? = nil
  var userDidTapPrivacyButton: Interaction? = nil
  var userDidTapContinueButton: Interaction? = nil
  
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
  
  private func setup() {
    self.addSubview(titleLabel)
    self.addSubview(descriptionLabel)
    self.addSubview(tosButton)
    self.addSubview(privacyButton)
    self.addSubview(continueButton)
    
    #if UITESTING
    self.setAcceccibilityIdentifiers()
    #endif
    
    self.tosButton.addTarget(self, action: #selector(self.tosButtonTapped(_:)), for: .touchUpInside)
    self.privacyButton.addTarget(self, action: #selector(self.privacyButtonTapped(_:)), for: .touchUpInside)
    self.continueButton.addTarget(self, action: #selector(self.continueButtonTapped(_:)), for: .touchUpInside)
    
  }
  
  @objc private func tosButtonTapped(_ sender: UIControl) {
    self.userDidTapTosButton?()
  }
  @objc private func privacyButtonTapped(_ sender: UIControl) {
    self.userDidTapPrivacyButton?()
  }
  @objc private func continueButtonTapped(_ sender: UIControl) {
    self.userDidTapContinueButton?()
  }
  
  private func style() {
    self.backgroundColor = .white
    self.titleLabel.text = "Welcome"
    self.titleLabel.numberOfLines = 1
    self.titleLabel.textAlignment = .center
    self.descriptionLabel.text = "To Continue Accept Terms of Services\nand Privacy Policy"
    self.descriptionLabel.numberOfLines = 0
    self.descriptionLabel.textAlignment = .center
    
    self.continueButton.setTitle("Continue", for: .normal)
    self.continueButton.setTitleColor(.black, for: .normal)
    self.continueButton.setTitleColor(.gray, for: .disabled)
    self.continueButton.setTitleColor(.gray, for: .highlighted)
    Self.styleSelectableButton(
      self.tosButton,
      normalText: "Tap to accept TOS",
      selectedText: "TOS Accepted"
    )
    Self.styleSelectableButton(
      self.privacyButton,
      normalText: "Tap to Accept Privacy Policy",
      selectedText: "Privacy Policy Accepted"
    )
    
  }
  
  private func update(oldModel: LegalVM?) {
    self.continueButton.isEnabled = self.viewModel?.buttonEnabled ?? false
    self.tosButton.isSelected = self.viewModel?.tosChecked ?? false
    self.privacyButton.isSelected = self.viewModel?.privacyChecked ?? false
    
    self.setNeedsLayout()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    self.titleLabel.frame = .zero
    self.titleLabel.sizeToFit()
    self.titleLabel.frame = CGRect(
      x: (self.bounds.width - self.titleLabel.frame.size.width)/2,
      y: self.safeAreaInsets.top + 20,
      width: self.titleLabel.frame.size.width,
      height: self.titleLabel.frame.size.height
    )
    
    self.descriptionLabel.frame = .zero
    self.descriptionLabel.sizeToFit()
    self.descriptionLabel.frame = CGRect(
      x: (self.bounds.width - self.descriptionLabel.frame.width)/2,
      y: self.titleLabel.frame.maxY + 20,
      width: self.descriptionLabel.frame.width,
      height: self.descriptionLabel.frame.height
    )
    
    self.continueButton.frame = CGRect(
      x: 20,
      y: self.bounds.height - self.safeAreaInsets.bottom - 50,
      width: self.bounds.width - 40,
      height: 50
    )
    
    self.privacyButton.frame = CGRect(
      x: 20,
      y: self.continueButton.frame.minY - 50,
      width: self.bounds.width - 40,
      height: 30
    )
    
    self.tosButton.frame = CGRect(
      x: 20,
      y: self.privacyButton.frame.minY - 50,
      width: self.bounds.width - 40,
      height: 30
    )
  }
  
  
  static func styleSelectableButton(_ button: UIButton, normalText: String, selectedText: String) {
    button.setTitleColor(.red, for: .normal)
    button.setTitleColor(.green, for: .selected)
    button.setTitleColor(UIColor.red.withAlphaComponent(0.75), for: .highlighted)
    button.setTitle(normalText, for: .normal)
    button.setTitle(selectedText, for: .selected)
  }
}

// MARK: - Accessibility
#if UITESTING
extension LegalView {
  enum AccessibilityIdentifiers: String {
    case legalView = "legal_view"
    case tosButton = "legal_view.tos_button"
    case privacyButton = "legal_view.privacy_button"
    case continueButton = "legal_view.continue_button"
  }
  
  func setAcceccibilityIdentifiers() {
    self.accessibilityIdentifier = AccessibilityIdentifiers.legalView.rawValue
    self.tosButton.accessibilityIdentifier = AccessibilityIdentifiers.tosButton.rawValue
    self.privacyButton.accessibilityIdentifier = AccessibilityIdentifiers.privacyButton.rawValue
    self.continueButton.accessibilityIdentifier = AccessibilityIdentifiers.continueButton.rawValue
  }
}
#endif
