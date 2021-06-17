//
//  AppDelegate.swift
//  Yassy
//
//  Created by Tanirbergen Kaldibai on 24.02.2021.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        
        let userDefaults = UserDefaults.standard
        
        
        // MARK: - Window

        let valid = UserDefaults.standard.string(forKey: Tokens.token)
        window = UIWindow(frame: UIScreen.main.bounds)
        //UserDefaults.standard.removeObject(forKey: Tokens.token)
        if valid == nil{
            let navigationController = UINavigationController(rootViewController: SplashScreenViewController())
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        } else {
            let navigationController = UINavigationController(rootViewController: HomeVC(viewModel: HomeViewModel(dataManager: DataManager()), addressViewModel: MainViewModel(dataManager: DataManager()), lat: 0, lng: 0))
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }

        if userDefaults.object(forKey: "ApplicationIdentifier") == nil {
            let UUID = NSUUID().uuidString
            userDefaults.set(UUID, forKey: "ApplicationIdentifier")
            userDefaults.synchronize()
        }

        print(userDefaults.object(forKey: "ApplicationIdentifier")!)
        print("DEVICE ID")

        print(Messaging.messaging().fcmToken ?? "")
        print("DEVICE TOKEN")

        // Register with APNs
        UIApplication.shared.registerForRemoteNotifications()
        return true
    }
    
    

//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
//        {
//            let tokenChars = (deviceToken as NSData).bytes.bindMemory(to: CChar.self, capacity: deviceToken.count)
//            var tokenString = ""
//
//            for i in 0..<deviceToken.count {
//                tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
//            }
//        print("tokenString: \(tokenString)")
//    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//    }

    
//    if #available(iOS 10.0, *) {
//      // For iOS 10 display notification (sent via APNS)
//      UNUserNotificationCenter.current().delegate = self
//
//      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//      UNUserNotificationCenter.current().requestAuthorization(
//        options: authOptions,
//        completionHandler: {_, _ in })
//    } else {
//      let settings: UIUserNotificationSettings =
//      UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//      application.registerUserNotificationSettings(settings)
//    }
//
//    application.registerForRemoteNotifications()

}

