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
  var viewModel: Models.User?
  
  var rootView: HomeView {
    return self.view as! HomeView
  }
  
  override func loadView() {
    self.view = HomeView()
    self.rootView.viewModel = HomeVM(user: self.viewModel)
  }
  
  init(user: Models.User?) {
    self.viewModel = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
}
