//
//  Constants.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 11/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

struct Constants {
    struct Strings {
        static let alertTitle = "Atenção"
        static let alertButton = "Ok"
    }
    
    struct Networking {
        static let baseUrl = "http://apilayer.net/api"
        static let accessKey = "ce7cc9678c03f001a7066496d5d10455"
    }
    
    struct Errors {
        static let apiDefaultMessage = "Error trying to connect to the server."
        static let failToBuildUrl = "Error tryind to build url."
    }
    
    struct Notifications {
        static let appTimeout = Notification.Name("AppTimeOut")
    }
}
