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
    
    var dataSource :[Dictionary<String, String>]?

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        dataSource = CollectionHelper.getObject(CollectionHelper.COLLECTION_INDEX)?.valueForKey("items") as? [Dictionary<String, String>]
        
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
        cell.nameLabel.text = item["name"]
        return cell
    }


}

