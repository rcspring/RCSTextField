//
//  RCSTextField.swift
//  shopper
//
//  Created by Ryan Spring on 3/31/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit

class RCSQuantityTextField : RCSTextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        value = RCSTextFieldValue.quantity(0.0)
    }
    
    //MARK:- TextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textL = textField.text else {
            return true
        }
        
        let newString = (textL as NSString).replacingCharacters(in: range, with: string)
        setQuantity(string:newString)
    
        return true
    }
    
    //MARK:- Private Methods

    
    private func setQuantity(string quantityString:String) {
        if quantityString.characters.count == 0 {
            value = .quantity(0.0)
            return
        }
        
        let number = RCSQuantityTextField.nForm.number(from: quantityString)!
        value = .quantity(number.doubleValue)
        
        valueDelegate?.fieldValueDidChange(field: self)
    }
    
    private func zeroQuantity() {
        text = ""
    }
}

