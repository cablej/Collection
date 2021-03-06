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
    
    enum SCHEMA_TYPES: String {
        case String = "String"
        case Int = "Int"
        case Float = "Float"
        case Image = "Image"
    }
    
    static let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    class func getObject(index: Int) -> NSManagedObject? {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Class")
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            let data = results as! [NSManagedObject]
            if(data.count == 0) {
                initializeDatabase([
                    ["name": "name", "type": SCHEMA_TYPES.String.rawValue],
                    ["name": "description", "type": SCHEMA_TYPES.String.rawValue],
                    ["name": "year", "type": SCHEMA_TYPES.String.rawValue],
                    ["name": "front", "type": SCHEMA_TYPES.Image.rawValue],
                    ["name": "back", "type": SCHEMA_TYPES.Image.rawValue],
                    ["name": "ID", "type": SCHEMA_TYPES.String.rawValue],
                    ["name": "type", "type": SCHEMA_TYPES.String.rawValue]
                    ])
            }
            if(index > data.count - 1) {
                return nil
            }
            
            return data[index]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
            return nil
        }
    }
    
    class func getItem(itemIndex: Int, index: Int) -> Dictionary<String, AnyObject>? {
        if let items = CollectionHelper.getObject(index)?.valueForKey("items") as? [Dictionary<String, AnyObject>] {
            if itemIndex < items.count {
                return items[itemIndex]
            }
        }
        return nil
    }
    
    class func initializeDatabase(schema: [Dictionary<String, String>]) {
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
    
    class func updateSchema(schema: [Dictionary<String, String>], index: Int) {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Class")
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            let data = results as! [NSManagedObject]
            
            data[index].setValue(schema, forKey: "schema")
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }

    }
    
    class func addItem(properties: Dictionary<String, AnyObject>, index: Int) {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Class")
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            let data = results as! [NSManagedObject]
            var items = data[index].valueForKey("items") as! Array<Dictionary<String, AnyObject>>
            
            items.append(properties)
            
            data[index].setValue(items, forKey: "items")
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    class func updateItem(properties: Dictionary<String, AnyObject>, itemIndex: Int, index: Int) {
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Class")
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            let data = results as! [NSManagedObject]
            var items = data[index].valueForKey("items") as! Array<Dictionary<String, AnyObject>>
            
            if(itemIndex >= items.count) {
                return
            }
            
            items[itemIndex] = properties
            
            data[index].setValue(items, forKey: "items")
            try managedContext.save()
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
}
