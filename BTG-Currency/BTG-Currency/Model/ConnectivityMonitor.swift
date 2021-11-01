//
//  ConnectivityMonitor.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 29/10/21.
//

import Network
import Combine

public class ConnectivityMonitor {
    let monitor = NWPathMonitor()
    
    var publisher: AnyPublisher<Bool, Never> {
        subject.eraseToAnyPublisher()
    }
    
    private let subject = PassthroughSubject<Bool, Never>()
    
    static var shared = ConnectivityMonitor()
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.subject.send(true)
            } else {
                self?.subject.send(false)
            }
        }
        
        let queue = DispatchQueue(label: "ConnectivityMonitor")
        monitor.start(queue: queue)
    }
}
