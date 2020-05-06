//
//  AppDelegate.swift
//  Screens
//
//  Created by Gustavo Amaral on 29/04/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import Storage
import Networking
import Service

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        registerServices()
        return true
    }
    
    private func registerServices() {
        Services.register(Storage.self) { () -> SQLiteStorage in
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            return SQLiteStorage(.uri("\(path)/db.sqlite3"))
        }
        
        Services.register(Requester.self) { URLSessionRequester() }
        Services.register(HomeViewController.self) { HomeToCurrenciesCoordinator() }
    }
}

