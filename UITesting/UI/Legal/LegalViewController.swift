//
//  ViewController.swift
//  UITesting
//
//  Created by Riccardo Cipolleschi on 31/07/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import UIKit

class LegalViewController: UIViewController {
  var rootView: LegalView {
    return self.view as! LegalView
  }
  
  override func loadView() {
    self.view = LegalView()
    self.rootView.viewModel = LegalVM(tosChecked: false, privacyChecked: false)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.setupInteractions()
  }
  
  func setupInteractions() {
    self.rootView.userDidTapPrivacyButton = { [unowned self] in
      guard let oldVM = self.rootView.viewModel else {
        return
      }
      self.rootView.viewModel = LegalVM(
        tosChecked: oldVM.tosChecked,
        privacyChecked: !oldVM.privacyChecked
      )
    }
    
    self.rootView.userDidTapTosButton = { [unowned self] in
      guard let oldVM = self.rootView.viewModel else {
        return
      }
      self.rootView.viewModel = LegalVM(
        tosChecked: !oldVM.tosChecked,
        privacyChecked: oldVM.privacyChecked
      )
    }
    
    self.rootView.userDidTapContinueButton = {
      let optionalKeyWindow = UIApplication.shared.connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }
      
      guard let keyWindow = optionalKeyWindow else {
        return
      }

      keyWindow.rootViewController = HomeViewController(user: nil)
    }
  }
  
  
}

