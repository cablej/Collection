
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
    var updateItem: Dictionary<String, AnyObject>?
    
    var itemIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schema = CollectionHelper.getObject(CollectionHelper.COLLECTION_INDEX)?.valueForKey("schema") as? [Dictionary<String, String>]
    }
    
    func setUpdateItemIndex(itemIndexToSet: Int) {
        itemIndex = itemIndexToSet
        updateItem = CollectionHelper.getItem(itemIndex, index: CollectionHelper.COLLECTION_INDEX)
        tableView.reloadData()
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
        
        guard let schema = schema else {
            return cell
        }
        
        let item = schema[indexPath.row]
        cell.initializeSchema(item)
        
        if let updateItem = updateItem, let name = schema[indexPath.row]["name"], let value = updateItem[name] {
            cell.initializeValue(value)
        }
        
        return cell
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createButtonTapped(sender: AnyObject) {
        var object = Dictionary<String, AnyObject>()
        for cell in tableView.visibleCells {
            let cell = cell as! FormCell
            if let value = cell.value() {
                object[cell.name] = value;
            } else {
                object[cell.name] = "";
            }
        }
        
        if(itemIndex > -1) {
            CollectionHelper.updateItem(object, itemIndex: itemIndex, index: CollectionHelper.COLLECTION_INDEX)
        } else {
            CollectionHelper.addItem(object, index: CollectionHelper.COLLECTION_INDEX)
        }
        
        if let vc = self.presentingViewController as? ViewTableViewController {
            vc.item = updateItem
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
