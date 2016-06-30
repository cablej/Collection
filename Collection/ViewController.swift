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
    
    var dataSource :[Dictionary<String, AnyObject>]?

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
//        
//        CollectionHelper.updateSchema([
//            ["name": "name", "type": CollectionHelper.SCHEMA_TYPES.String.rawValue],
//            ["name": "description", "type": CollectionHelper.SCHEMA_TYPES.String.rawValue],
//            ["name": "year", "type": CollectionHelper.SCHEMA_TYPES.String.rawValue],
//            ["name": "front", "type": CollectionHelper.SCHEMA_TYPES.Image.rawValue],
//            ["name": "back", "type": CollectionHelper.SCHEMA_TYPES.Image.rawValue],
//            ["name": "ID", "type": CollectionHelper.SCHEMA_TYPES.String.rawValue],
//            ["name": "type", "type": CollectionHelper.SCHEMA_TYPES.String.rawValue]
//            ], index: CollectionHelper.COLLECTION_INDEX)
    }
    
    override func viewDidAppear(animated: Bool) {
        dataSource = CollectionHelper.getObject(CollectionHelper.COLLECTION_INDEX)?.valueForKey("items") as? [Dictionary<String, AnyObject>]
        
        self.tableView.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataSource = dataSource else {
            return 0
        }
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell") as! ItemCell
        let item = dataSource![indexPath.row]
        cell.nameLabel.text = item["name"] as? String
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? ViewTableViewController {
            vc.setViewItemIndex(tableView.indexPathForSelectedRow!.row)
        }
    }


}

