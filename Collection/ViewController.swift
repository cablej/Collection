//
//  ViewController.swift
//  Collection
//
//  Created by Jack Cable on 6/27/16.
//  Copyright © 2016 Jack Cable. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    var items = [NSManagedObject]()
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Item")
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            items = results as! [NSManagedObject]
            print(items)
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell") as! ItemCell
        let item = items[indexPath.row]
        let properties = item.valueForKey("properties") as! NSDictionary
        cell.nameLabel.text = properties.valueForKey("name") as? String
        return cell
    }
    
    func addItem() {
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Item",
                                                        inManagedObjectContext:managedContext)
        
        let item = NSManagedObject(entity: entity!,
                                   insertIntoManagedObjectContext: managedContext)
        
        item.setValue(["name": "myValue"], forKey: "properties")
        
        do {
            try managedContext.save()
            items.append(item)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }


}

