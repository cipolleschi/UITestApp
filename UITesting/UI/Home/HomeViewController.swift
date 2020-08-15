//
//  HomeViewController.swift
//  UITesting
//
//  Created by Riccardo Cipolleschi on 01/08/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
  var user: Models.User? {
    didSet {
      DispatchQueue.main.async {
        self.rootView.viewModel = HomeVM(user: self.user)
      }
    }
  }
  var dependencies: Dependencies
  
  var rootView: HomeView {
    return self.view as! HomeView
  }
  
  override func loadView() {
    self.view = HomeView()
    self.rootView.viewModel = HomeVM(user: self.user)
    self.setupInteraction()
  }
  
  init(user: Models.User?, dependencies: Dependencies) {
    self.user = user
    self.dependencies = dependencies
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupInteraction() {
    self.rootView.purchaseInteraction = { [unowned self] in
      self.dependencies.purchaseManager.purchaseProduct(productId: "1000Coins") { success in
        if success {
          self.user = self.user?.adding(coins: 1000)
        }
      }
    }
  }
}
