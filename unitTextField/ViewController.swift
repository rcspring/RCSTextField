//
//  ViewController.swift
//  unitTextField
//
//  Created by Ryan Spring on 4/5/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit

class ViewController: UIViewController, RCSUnitTextFieldDelegate {
    
    @IBOutlet var textField : RCSUnitTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.unitDelegate = self
        textField.measUnit = UnitVolume.milliliters
        textField.dismissButtonText = "Dismiss"
        textField.dismissButtonColor = UIColor.green
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- RCSTextFieldDelegate
    func textFieldDidComplete(field: RCSUnitTextField) {
        print("Completed with \(field.measurement)")
    }
    
    func textFieldValueDidChange(field: RCSUnitTextField) {
         print("Changed with \(field.measurement)")
    }


}

