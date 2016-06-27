//
//  CollectionHelper.swift
//  Collection
//
//  Created by Jack Cable on 6/27/16.
//  Copyright © 2016 Jack Cable. All rights reserved.
//

import UIKit
import CoreData

class CollectionHelper: NSObject {
    
    static let COLLECTION_INDEX = 0
    
    static let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    class func getObject(index: Int) -> NSManagedObject? {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Class")
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            let data = results as! [NSManagedObject]
            if(data.count == 0) {
                initializeDatabase(["name": "String", "description": "String"])
            }
            if(index > data.count - 1) {
                return nil
            }
            
            print(data[index].valueForKey("items")!)
            
            return data[index]
            //                self.addItem(["name": "myItem", "description":"hello"])
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return nil
        }
    }
    
    class func initializeDatabase(schema: Dictionary<String, String>) {
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Class",
                                                        inManagedObjectContext:managedContext)
        
        let item = NSManagedObject(entity: entity!,
                                   insertIntoManagedObjectContext: managedContext)
        
        item.setValue(schema, forKey: "schema")
        item.setValue([], forKey: "items")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    class func addItem(properties: Dictionary<String, String>) {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Class")
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            let data = results as! [NSManagedObject]
            var items = data[0].valueForKey("items") as! Array<Dictionary<String, String>>
            
            items.append(properties)
            
            data[0].setValue(items, forKey: "items")
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
}
