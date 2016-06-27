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
    
    var dataSource: NSManagedObject?

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        dataSource = CollectionHelper.getObject(CollectionHelper.COLLECTION_INDEX)
        
        self.tableView.reloadData()
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource!.valueForKey("items")!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ItemCell") as! ItemCell
        let item = dataSource!.valueForKey("items")![indexPath.row] as! NSDictionary
        cell.nameLabel.text = item.valueForKey("name") as? String
        return cell
    }


}

