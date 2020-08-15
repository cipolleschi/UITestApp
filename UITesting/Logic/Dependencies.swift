//
//  Dependencies.swift
//  UITesting
//
//  Created by Riccardo Cipolleschi on 14/08/20.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation

class Dependencies {
  let purchaseManager: PurchaseManager
  
  init(purchaseManagerDependencies: PurchaseManager.Dependencies = .live) {
    self.purchaseManager = PurchaseManager(dependencies: purchaseManagerDependencies)
  }
}
