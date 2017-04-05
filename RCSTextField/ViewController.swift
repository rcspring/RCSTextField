//
//  ViewController.swift
//  unitTextField
//
//  Created by Ryan Spring on 4/5/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RCSTextFieldDelegate {
    
    @IBOutlet var unitField : RCSUnitTextField!
    @IBOutlet var quantityField : RCSQuantityTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var configuration = RCSTextFieldConfiguration()
        configuration.dismissButtonColor = UIColor.gray
        configuration.dismissButtonText = "Dismiss"
        configuration.valueDelegate = self
        configuration.measUnit = UnitVolume.milliliters
        
        unitField.configuration = configuration
        quantityField.configuration = configuration
    }

    //MARK:- RCSTextFieldDelegate 
    func fieldDidComplete(field: RCSTextField) {
        print("QCompleted with \(field.value)")
    }
    
    func fieldValueDidChange(field: RCSTextField) {
        print("Changed with \(field.value)")
    }


}

