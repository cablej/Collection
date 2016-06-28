
//
//  CreateTableViewController.swift
//  Collection
//
//  Created by Jack Cable on 6/27/16.
//  Copyright © 2016 Jack Cable. All rights reserved.
//

import UIKit

class CreateTableViewController: UITableViewController {
    
    var schema: [Dictionary<String, String>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schema = CollectionHelper.getObject(CollectionHelper.COLLECTION_INDEX)?.valueForKey("schema") as? [Dictionary<String, String>]
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let schema = schema else {
            return 0
        }
        return schema.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FormCell") as! FormCell
        let item = schema![indexPath.row]
        cell.initializeSchema(item)
        return cell
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
