
//
//  ViewTableViewController.swift
//  Collection
//
//  Created by Jack Cable on 6/27/16.
//  Copyright © 2016 Jack Cable. All rights reserved.
//

import UIKit

class ViewTableViewController: UITableViewController {
    
    var item: Dictionary<String, AnyObject>?
    var schema: [Dictionary<String, String>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schema = CollectionHelper.getObject(CollectionHelper.COLLECTION_INDEX)?.valueForKey("schema") as? [Dictionary<String, String>]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ViewCell") as! ViewCell
        let property = Array(arrayLiteral: item?.values)[indexPath.row] as? AnyObject
        cell.initializeSchema(property!, schemaToSet: schema![indexPath.row])
        return cell
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
