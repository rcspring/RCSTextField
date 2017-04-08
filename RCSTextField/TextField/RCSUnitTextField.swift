//
//  RCSTextField.swift
//  shopper
//
//  Created by Ryan Spring on 3/31/17.
//  Copyright © 2017 Ryan Spring. All rights reserved.
//

import UIKit

public class RCSUnitTextField : RCSTextField {
    
    private var unitString : String
    private var suffixString : String
    
    override public var configuration: RCSTextFieldConfiguration {
        didSet {
            zeroMeasurement()
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        unitString = ""
        suffixString = " "

        super.init(coder: aDecoder)
        value = .measurment(Measurement(value: 0.0, unit: configuration.measUnit))
        
        unitString = configuration.measUnit.symbol
        suffixString = " " + unitString
        super.keyboardType = .decimalPad
        
       // text = text! + suffixString
    }
    
    //MARK:- TextField Delegate
    override public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let textL = textField.text else {
            return true
        }
        
        if textL.characters.count == 0 && string.characters.count > 0 {
            textField.text = suffixString
        }
               
        if range.location + range.length > textL.characters.count - suffixString.characters.count {
            textField.selectedTextRange = pointRangeFromEnd(offset: -suffixString.characters.count)
            return false
        }
        
        let newString = (textL as NSString).replacingCharacters(in: range, with: string)
        
        
        
        setMeasurement(string:newString)
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if let textL = text, textL.isEmpty {
            text = suffixString
        }
        
        textField.selectedTextRange = pointRangeFromEnd(offset: -suffixString.characters.count)
    }
    
    //MARK:- Private Methods
    private func pointRangeFromEnd(offset offsetVal:Int)->UITextRange? {
        let endPos = position(from: endOfDocument, offset: offsetVal)!
        return textRange(from: endPos, to: endPos)
    }
    
    private func setMeasurement(string quantityString:String) {
    
        let suffixBeginIdx = quantityString.characters.index(quantityString.endIndex, offsetBy: -suffixString.characters.count)
        let measurementQuantity = quantityString.substring(to: suffixBeginIdx)
        
        if measurementQuantity.characters.count == 0 {
            value = .measurment(Measurement(value: 0.0, unit: configuration.measUnit))
            text = ""
            return
        }
        
        let number = RCSUnitTextField.nForm.number(from: measurementQuantity)!
        value = .measurment(Measurement(value: number.doubleValue, unit: configuration.measUnit))
        shadowDelegate?.fieldValueDidChange(field: self)
    }
    
    private func zeroMeasurement() {
        unitString = configuration.measUnit.symbol
        suffixString = " " + unitString
        value = .measurment(Measurement(value: 0.0, unit: configuration.measUnit))
    }
    
    
}

