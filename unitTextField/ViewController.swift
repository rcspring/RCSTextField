//
//  ViewController.swift
//  unitTextField
//
//  Created by Ryan Spring on 4/5/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RCSTextFieldDelegate {
    
    @IBOutlet var textField : RCSUnitTextField!
    @IBOutlet var quantityField : RCSQuantityTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.valueDelegate = self 
        textField.measUnit = UnitVolume.milliliters
        textField.dismissButtonText = "Dismiss"
        textField.dismissButtonColor = UIColor.green
//
        quantityField.valueDelegate = self
        quantityField.dismissButtonText = "Dismiss"
        quantityField.dismissButtonColor = UIColor.red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- RCSTextFieldDelegate 
    func fieldDidComplete(field: RCSTextField) {
        print("QCompleted with \(field.value)")
    }
    
    func fieldValueDidChange(field: RCSTextField) {
        print("Changed with \(field.value)")
    }


}

