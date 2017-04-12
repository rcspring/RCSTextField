//
//  ViewController.swift
//  unitTextField
//
//  Created by Ryan Spring on 4/5/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit
import RCSTextField

class ViewController: UIViewController, RCSUnitTextFieldDelegate, RCSUnitSegmentedControlDelegate {
    @IBOutlet var unitField: RCSUnitTextField!
    @IBOutlet var quantityField: RCSQuantityTextField!

    // MARK: RCSTextFieldDelegate
    func measUnitForTextField(field: RCSUnitTextField) -> Unit {
        return UnitVolume.acreFeet
    }

    func fieldDidComplete(field: RCSTextField) {
        print("Completed with \(field.value)")
    }

    func fieldValueDidChange(field: RCSTextField) {
        print("Changed with \(field.value)")
    }

    func new(unit: Dimension?, idx: Int, on control: RCSUnitSegmentedControl) {
        print("New unit \(unit) idx \(idx) on \(control)")
    }

    func dataModel() -> [(String, Dimension?)] {
        return [("Test1", nil), ("Test2", nil), ("Test3", nil)]
    }
}
