//
//  SceneDelegate.swift
//  UITesting
//
//  Created by Riccardo Cipolleschi on 31/07/2020.
//  Copyright © 2020 Riccardo Cipolleschi. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  var user: Models.User?
  var dependencies: Dependencies!
  
  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    guard let scene = (scene as? UIWindowScene) else { return }
    #if UITESTING
    self.resetIfNeeded()
    #endif
    
    self.dependencies = buildDependencies()
    let vc = buildViewController()
    let window = UIWindow(windowScene: scene)
    window.rootViewController = vc
    window.makeKeyAndVisible()
    self.window = window
  }
  #if UITESTING
  func resetIfNeeded() {
    guard UserDefaults.standard.bool(forKey: "reset") else {
      return
    }
    
    
    // put the code to reset the state, remove eventual local files
    // and remove the keys from the UserDefaults, if any.
  }
  #endif
  
  func buildViewController() -> UIViewController {
    
    #if UITESTING
    return self.vcForUITesting()
    #endif
    
    return LegalViewController(dependencies: self.dependencies)
  }
  
  func buildDependencies() -> Dependencies {
    #if UITESTING
    if UserDefaults.standard.object(forKey: "mockPurchase") != nil {
      let mockedMonetizationResult = UserDefaults.standard.bool(forKey: "mockPurchase")
      return Dependencies(purchaseManagerDependencies: .mocked(with: mockedMonetizationResult))
    }
    #endif
    return Dependencies()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
  }
  
  func sceneDidBecomeActive(_ scene: UIScene) {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
  }
  
  func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
  }
  
  func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
  }
  
  func sceneDidEnterBackground(_ scene: UIScene) {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
  }
  
  
}

#if UITESTING
extension SceneDelegate {
  func extractState() -> Models.User? {
    guard
      let state = UserDefaults.standard.string(forKey: "statePath"),
      let fileContent = try? String(contentsOfFile: state),
      let fileData = fileContent.data(using: .utf8)
    else {
      return nil
    }
    
    return try? JSONDecoder().decode(Models.User.self, from: fileData)
  }
  
  func vcForUITesting() -> UIViewController {
    let user: Models.User? = self.extractState()
    let initialScreen = UserDefaults.standard.string(forKey: "initialScreen")
    if initialScreen == "home_screen" {
      return HomeViewController(user: user, dependencies: self.dependencies)
    }
    return LegalViewController(dependencies: Dependencies())
  }
}
#endif
