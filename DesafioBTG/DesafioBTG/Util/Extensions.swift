//
//  Extensions.swift
//  DesafioBTG
//
//  Created by Rodrigo Goncalves on 06/11/20.
//

import UIKit
import CoreData

extension UIViewController {
    
    var context: NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    
    
}

protocol SelectedCurrencyDelegate: class {
    
    func setSelectedCurrency(_ currency: CurrencyInfo)
    
}
