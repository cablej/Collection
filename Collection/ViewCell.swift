//
//  ViewCell.swift
//  Collection
//
//  Created by Jack Cable on 6/28/16.
//  Copyright © 2016 Jack Cable. All rights reserved.
//

import UIKit

class ViewCell: UITableViewCell {
    
    @IBOutlet var fieldNameLabel: UILabel!
    
    @IBOutlet var valueLabel: UILabel!
    
    
    var property: AnyObject?
    var schema = Dictionary<String, String>()
    var type = ""
    var name = ""
    
    func initializeSchema(propertyToSet: AnyObject, schemaToSet: Dictionary<String, String>) {
        property = propertyToSet
        schema = schemaToSet
        fieldNameLabel.text = name
        if type == CollectionHelper.SCHEMA_TYPES.String.rawValue {
            valueLabel.hidden = false
            valueLabel.text = propertyToSet as! String
        } else {
        }
    }
    
}
