//
//  Storyboarded.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 24/09/21.
//

import UIKit

public protocol Storyboarded {
    static func instantiate(storyboardName: String, bundle: Bundle?) -> Self
}

public extension Storyboarded where Self: UIViewController {
    
    static func instantiate(storyboardName: String, bundle: Bundle?) -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
        
    }
    
}

