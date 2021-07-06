//
//  NetworkMonitor.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 02/11/20.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    public private(set) var connectionType: ConnectionType = .unknown
    
    enum ConnectionType {
        case wifi, cellular, ethernet, unknown
    }
    
    private init(){
        self.monitor = NWPathMonitor()
    }
    
    public func startMonitoring(){
        self.monitor.start(queue: self.queue)
        self.monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            self.isConnected = path.status != .unsatisfied
            self.getConnectionType(path)
        }
    }
    
    public func stopMonitoring(){
        self.monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath){
        if path.usesInterfaceType(.wifi){
            self.connectionType = .wifi
        }else if path.usesInterfaceType(.cellular){
            self.connectionType = .cellular
        }else if path.usesInterfaceType(.wiredEthernet){
            self.connectionType = .ethernet
        }else {
            self.connectionType = .unknown
        }
    }
}
