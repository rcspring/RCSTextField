//
//  ViewController.swift
//  unitTextField
//
//  Created by Ryan Spring on 4/5/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit
import RCSTextField

class ViewController: UIViewController, RCSUnitTextFieldDelegate {
    
    @IBOutlet var unitField : RCSUnitTextField!
    @IBOutlet var quantityField : RCSQuantityTextField!

    //MARK:- RCSTextFieldDelegate 
    func fieldDidComplete(field: RCSTextField) {
        print("Completed with \(field.value)")
    }
    
    func fieldValueDidChange(field: RCSTextField) {
        print("Changed with \(field.value)")
    }


}

