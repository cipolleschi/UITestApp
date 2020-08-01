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
  var rootView: HomeView {
    return self.view as! HomeView
  }
  
  override func loadView() {
    self.view = HomeView()
    self.rootView.viewModel = HomeVM()
  }
  
  
}
