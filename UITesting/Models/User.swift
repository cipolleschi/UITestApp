//
//  User.swift
//  UITesting
//
//  Created by Riccardo Cipolleschi on 09/08/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import Foundation

enum Models {
  struct User: Codable {
    let name: String
    let surname: String
    let age: Int
    let coins: Int
    
    func adding(coins: Int) -> User {
      return User(name: self.name, surname: self.surname, age: self.age, coins: self.coins + coins)
    }
  }
}
