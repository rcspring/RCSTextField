//
//  ViewController.swift
//  unitTextField
//
//  Created by Ryan Spring on 4/5/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RCSUnitTextFieldDelegate, RCSQuantityTextFieldDelegate {
    
    @IBOutlet var textField : RCSUnitTextField!
    @IBOutlet var quantityField : RCSQuantityTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.unitDelegate = self
        textField.measUnit = UnitVolume.milliliters
        textField.dismissButtonText = "Dismiss"
        textField.dismissButtonColor = UIColor.green
        
        quantityField.quantityDelegate = self
        quantityField.dismissButtonText = "Dismiss"
        quantityField.dismissButtonColor = UIColor.red
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- RCSUnitTextFieldDelegate
    func textFieldDidComplete(field: RCSUnitTextField) {
        print("Completed with \(field.measurement)")
    }
    
    func textFieldValueDidChange(field: RCSUnitTextField) {
         print("Changed with \(field.measurement)")
    }
    
    //MARK:- RCSQuantityTextFieldDelegate 
    func quantityFieldDidComplete(field: RCSQuantityTextField) {
        print("QCompleted with \(field.quantity)")
    }
    
    func quantityFieldValueDidChange(field: RCSQuantityTextField) {
        print("Changed with \(field.quantity)")
    }


}

