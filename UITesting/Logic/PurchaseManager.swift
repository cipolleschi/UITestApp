//
//  PurchaseManager.swift
//  UITesting
//
//  Created by Riccardo Cipolleschi on 14/08/20.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation
import StoreKit

class PurchaseManager {
  struct Dependencies {
    let purchaseProduct: (_ productId: String, _ callback: @escaping (Bool) -> Void) -> Void
  }
  
  let dependencies: Dependencies
  
  init(dependencies: Dependencies) {
    self.dependencies = dependencies
  }
  
  func purchaseProduct(productId: String, callback: @escaping  (Bool) -> Void) -> Void {
    self.dependencies.purchaseProduct(productId, callback)
  }
}

extension PurchaseManager.Dependencies {
  static var live = Self { productId, callback in
    // Usually perform StoreKit processing
    DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
      callback(true)
    }
  }
  
  #if UITESTING
  static func mocked(with result: Bool) -> Self {
    return Self { productId, callback in
      callback(result)
    }
  }
  #endif
}
