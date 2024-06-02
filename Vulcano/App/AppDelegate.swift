//
//  AppDelegate.swift
//  Vulcano
//
//  Created by Bema on 29/5/24.
//

import UIKit
import UserNotifications
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
      _ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // ... existing code ...
      registerForPushNotifications()
      return true
    }
    
}

func registerForPushNotifications() {
  UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
    (granted, error) in
    print("Permission granted: \(granted)")
  }
}

