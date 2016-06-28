//
//  FormCell.swift
//  Collection
//
//  Created by Jack Cable on 6/28/16.
//  Copyright © 2016 Jack Cable. All rights reserved.
//

import UIKit

class FormCell: UITableViewCell {
    
    @IBOutlet var fieldNameLabel: UILabel!
    
    @IBOutlet var textField: UITextField!
    
    var schema = Dictionary<String, String>()
    var type = ""
    var name = ""
    
    func initializeSchema(schemaToSet: Dictionary<String, String>) {
        schema = schemaToSet
        guard let type = schema["type"], let name = schema["name"] else {
            return
        }
        fieldNameLabel.text = name
        if type == CollectionHelper.SCHEMA_TYPES.String.rawValue {
            textField.hidden = false
            textField.enabled = true
        } else {
            textField.hidden = true
            textField.enabled = false
        }
    }
    
    func value() -> String? {
        if type == CollectionHelper.SCHEMA_TYPES.String.rawValue {
            return textField.text
        } else {
            self.textField.hidden = true
            self.textField.enabled = false
            return nil
        }
    }
    
}
