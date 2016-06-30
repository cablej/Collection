
//
//  ViewTableViewController.swift
//  Collection
//
//  Created by Jack Cable on 6/27/16.
//  Copyright © 2016 Jack Cable. All rights reserved.
//

import UIKit

class ViewTableViewController: UITableViewController {
    
    var itemIndex = -1;
    var item: Dictionary<String, AnyObject>?
    var schema: [Dictionary<String, String>]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        schema = CollectionHelper.getObject(CollectionHelper.COLLECTION_INDEX)?.valueForKey("schema") as? [Dictionary<String, String>]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        updateData()
    }
    
    func setViewItemIndex(itemIndexToSet: Int) {
        itemIndex = itemIndexToSet
    }
    
    func updateData() {
        if itemIndex > -1 {
            item = CollectionHelper.getItem(itemIndex, index: CollectionHelper.COLLECTION_INDEX)
            tableView.reloadData()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let item = item else {
            return 0
        }
        
        return item.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ViewCell") as! ViewCell
        
        guard let item = item, let schema = schema else {
            return cell
        }
        
        var property: AnyObject?
        if let name = schema[indexPath.row]["name"], let value = item[name] {
            property = value
        }
        
        if property == nil {
            property = ""
        }
        
        cell.initializeProperty(property!, schemaToSet: schema[indexPath.row])
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nvc = segue.destinationViewController as? UINavigationController {
            if let vc = nvc.viewControllers.first as? CreateTableViewController {
                vc.itemIndex = itemIndex
                vc.setUpdateItemIndex(itemIndex)
            }
        }
    }
    
}
