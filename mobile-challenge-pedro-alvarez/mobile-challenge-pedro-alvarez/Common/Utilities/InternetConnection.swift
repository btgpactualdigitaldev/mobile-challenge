//
//  InternetConnection.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 28/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import Network

class InternetConnection {
    
    private let monitor = NWPathMonitor()
    
    static var shared = InternetConnection()
    
    var isConnected: Bool = true
    
    private init() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
