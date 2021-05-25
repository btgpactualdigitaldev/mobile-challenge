//
//  AppDelegate.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 19/05/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                                                        
        if let _ = UserDefaultsPersistenceManager()
            .getCurrencies(withKey: Constants.LIST_CURRENCIES_KEY),
              let _ = UserDefaultsPersistenceManager()
                .getConversionQuotes(withKey: Constants.QUOTES_KEY) {
            return true
        } else {
            if NetworkManager().hasInternetConnection() {
                NetworkManager().fetchCurrenciesList { currs in
                    if let currenciesToSave = currs?.sorted(by: { $0.code < $1.code }) {
                        _ = UserDefaultsPersistenceManager().saveCurrencies(currenciesToSave,
                                                                            withKey: Constants.LIST_CURRENCIES_KEY)
                    }
                }
                
                NetworkManager().fetchConversionList { convQts in
                    if let convQts = convQts {
                        _ = UserDefaultsPersistenceManager().saveConversionQuotes(convQts,
                                                                                  withKey: Constants.QUOTES_KEY)
                    }
                }
            } else {
                self.window?.rootViewController?.present(AlertFactory.defaultNoInternetAlert, animated: true, completion: nil)
            }
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

