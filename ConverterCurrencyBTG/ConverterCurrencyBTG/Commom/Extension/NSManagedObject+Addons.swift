//
//  NSManagedObject+Addons.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObject {

  class var entityName: String {
    let fullClassName = NSStringFromClass(object_getClass(self)!)
    let classNameComponents = fullClassName.components(separatedBy: ".")
    return classNameComponents.last!
  }

  class func insertNew(in context: NSManagedObjectContext) -> Self {
    let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context)!
    return self.init(entity: entityDescription, insertInto: context)
  }

  class func deleteAll(in context: NSManagedObjectContext) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)

    do {
      let matches = try context.fetch(fetchRequest)

      for match in matches where match is NSManagedObject {
        context.delete(match as! NSManagedObject)
      }
    }
    catch {}
  }

}
